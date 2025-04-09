#include "qmlmqttclient.h"
#include <QDebug>
#include<QStandardPaths>
#include<QDir>
QmlMqttSubscription::QmlMqttSubscription(QMqttSubscription *s, QmlMqttClient *c)
    : sub(s)
    , client(c)
{
    connect(sub, &QMqttSubscription::messageReceived, this, &QmlMqttSubscription::handleMessage);
    m_topic = sub->topic();
}

QmlMqttSubscription::~QmlMqttSubscription()
{
}

QmlMqttClient::QmlMqttClient(QObject *parent)
    : QObject(parent)
{
    connect(&m_client, &QMqttClient::hostnameChanged, this, &QmlMqttClient::hostnameChanged);
    connect(&m_client, &QMqttClient::portChanged, this, &QmlMqttClient::portChanged);
    connect(&m_client, &QMqttClient::stateChanged, this, &QmlMqttClient::stateChanged);

    QString path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir().mkpath(path);
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(QDir::homePath() + "/data.db");

    if(!m_db.open()) {
        qDebug() << "Cannot open database:" << m_db.lastError().text();
    }else {
        qDebug() << "Database opened!";
        QSqlQuery query(m_db);
        bool tableCreated = query.exec("CREATE TABLE IF NOT EXISTS mqtt_messages ("
                                       "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                                       "topic TEXT,"
                                       "message TEXT,"
                                       "timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)");
        if(!tableCreated){
            qDebug() << "failed to create table" ;
        }else {
            qDebug() << "Table created with success!";
        }

    }


}

void QmlMqttClient::connectToHost()
{
    m_client.connectToHost();
}

void QmlMqttClient::disconnectFromHost()
{
    m_client.disconnectFromHost();
}

QmlMqttSubscription* QmlMqttClient::subscribe(const QString &topic)
{
    auto sub = m_client.subscribe(topic, 0);
    auto result = new QmlMqttSubscription(sub, this);
    result->m_db = m_db;
    return result;
}

void QmlMqttSubscription::handleMessage(const QMqttMessage &qmsg)
{
    const QString payload = qmsg.payload();
    const QString topic = qmsg.topic().name();


    emit messageReceived(qmsg.payload());

    if(m_db.isOpen()) {
        QSqlQuery query(m_db);

        QDateTime currentTime = QDateTime::currentDateTime();
        QString timestamp = currentTime.toString("yyyy-MM-dd hh:mm:ss");

        query.prepare("INSERT INTO mqtt_messages (topic, message, timestamp) VALUES (:topic, :message, :timestamp )");
        query.bindValue(":topic", topic);
        query.bindValue(":message", payload);
        query.bindValue(":timestamp", timestamp);
        if(!query.exec()) {
            qWarning() << "Failed to insert message" << query.lastError().text();
            qWarning() << "Query was: " << query.lastQuery();
        }
    }
}

const QString QmlMqttClient::hostname() const
{
    return m_client.hostname();
}

void QmlMqttClient::setHostname(const QString &newHostname)
{
    m_client.setHostname(newHostname);
}

int QmlMqttClient::port() const
{
    return m_client.port();
}

void QmlMqttClient::setPort(int newPort)
{
    if (newPort < 0 || newPort > std::numeric_limits<quint16>::max()) {
        qWarning() << "Trying to set invalid port number";
        return;
    }
    m_client.setPort(static_cast<quint16>(newPort));
}

const QMqttClient::ClientState QmlMqttClient::state() const
{
    return m_client.state();
}

void QmlMqttClient::setState(const QMqttClient::ClientState &newState)
{
    m_client.setState(newState);
}
