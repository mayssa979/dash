#include "databasemanager.h"

DatabaseManager::DatabaseManager(QObject *parent) : QObject(parent) {
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("sensors.db");

    if(!db.open()) {
        qWarning() << "Impossible d'ouvrir la base SQLite: ";
    }else {
        initialize();
    }
}

void DatabaseManager::initialize() {
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS sensor_data("
               "id INTEGER PRIMARY KEY AUTOINCREMENT,"
               "type TEXT,"
               "value REAL,"
               "timestamp TEXT)");
}

bool DatabaseManager::insertData(const QString &type, float value, const QString &timestamp) {
    QSqlQuery query;
    query.prepare("INSERT INTO sensor_data (type, value, timestamp) VALUES (?,?,?)");
    query.addBindValue(type);
    query.addBindValue(value);
    query.addBindValue(timestamp);

    return query.exec();
}
