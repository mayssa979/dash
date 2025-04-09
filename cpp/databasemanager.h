#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QDebug>

class DatabaseManager : public QObject {
    Q_OBJECT

public :
    explicit DatabaseManager(QObject *parent = nullptr);
    bool insertData(const QString &type, float value, const QString &timestamp);

private :
    QSqlDatabase db;
    void initialize();
};


#endif // DATABASEMANAGER_H
