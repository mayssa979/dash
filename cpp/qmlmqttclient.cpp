#include "qmlmqttclient.h"
#include <QDebug>

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


    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName("qrc:/SmartDashboard/data.db");

    if(!m_db.open()) {
        qDebug() << "Cannot open database:" << m_db.lastError().text();
    }else {
        QSqlQuery query(m_db);
        query.exec("CREATE TABLE IF NOT EXISTS mqtt_messases ("
                   "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                   "topic TEXT,"
                   "message TEXT,"
                   "timestamp DATETIME DEFAULT CURRENT_TIMESTAMP");
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
        query.prepare("INSERT INTO mqtt_messages (topic, message) VALUES (:topic, :message )");
        query.bindValue(":topic", topic);
        query.bindValue(":message", payload);
        if(!query.exec()) {
            qWarning() << "Failed to insert message" << query.lastError().text();
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
