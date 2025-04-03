#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QFont>
#include <QQuickStyle>
#include <QtMqtt/QMqttClient>
#include "qmlmqttclient.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Basic");

    QFontDatabase::addApplicationFont(":/SmartDashboard/assets/fonts/CodecPro-Regular.ttf");

    QFont font("Codec Pro");
    QGuiApplication::setFont(font);
    qmlRegisterType<QmlMqttClient>("QtMqtt", 2, 0, "MqttClient");
    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/SmartDashboard/qml/Main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
