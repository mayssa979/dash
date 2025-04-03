import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls as QQC2
import QtMqtt


Item {
    id: rightItem
    width: 300
    height: parent.height
    anchors.left: leftItem.right
    anchors.leftMargin: 22
    property var tempSubscription: 0

    MqttClient {
        id: client
        hostname: String(hostField.text)
        port: Number(portField.text)
    }

    ListModel {
        id: messageModel
    }

    function addMessage(payload)
    {
        messageModel.insert(0, {"payload" : payload})

        if (messageModel.count >= 100)
            messageModel.remove(99)
    }
    property bool isConnected: false

    ColumnLayout {
        anchors.fill: parent
        spacing: 16

        Rectangle {
            visible: activeMenuLabel === "Connect"
            color: glassyBgColor
            radius: 16
            Layout.fillWidth: true
            Layout.preferredHeight: connectPanel.height + lightswitchescol.height + 120

            ColumnLayout {
                id: connectPanel
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 24
                spacing: 12

                // Host Input
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    QQC2.Label {
                        text: qsTr("Host:")
                        color: textColor
                        Layout.preferredWidth: 80
                        enabled: client.state === MqttClient.Disconnected
                    }

                    QQC2.TextField {
                        id: hostField
                        Layout.fillWidth: true
                        placeholderText: qsTr("Enter MQTT host")
                        enabled: client.state === MqttClient.Disconnected
                    }
                }

                // Port Input
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    QQC2.Label {
                        text: qsTr("Port:")
                        color: textColor
                        Layout.preferredWidth: 80
                        enabled: client.state === MqttClient.Disconnected
                    }

                    QQC2.TextField {
                        id: portField
                        Layout.fillWidth: true
                        placeholderText: qsTr("Enter port")
                        inputMethodHints: Qt.ImhDigitsOnly
                        enabled: client.state === MqttClient.Disconnected
                    }
                }

                // Connect Button
                QQC2.Button {
                    Layout.alignment: Qt.AlignHCenter
                    id: connectButton
                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    text: client.state === MqttClient.Connected ? "Disconnect" : "Connect"
                    onClicked: {
                        if (client.state === MqttClient.Connected) {
                            client.disconnectFromHost()
                            messageModel.clear()
                            rightItem.tempSubscription.destroy()
                            rightItem.tempSubscription = 0
                        } else
                            client.connectToHost()
                    }
                }

                // Disabled Topic Input (Enabled after connection)
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8
                    enabled: client.state === MqttClient.Connected

                    QQC2.Label {
                        text: qsTr("Topic:")
                        color: textColor
                        Layout.preferredWidth: 80
                    }

                    QQC2.TextField {
                        id: topicField
                        Layout.fillWidth: true
                        placeholderText: qsTr("Enter topic")
                        enabled: rightItem.tempSubscription === 0
                    }
                }


                QQC2.Button {
                    text: qsTr("Subscribe")
                    Layout.alignment: Qt.AlignHCenter
                    visible: rightItem.tempSubscription === 0
                    onClicked: {
                        if (topicField.text.length === 0) {
                            console.log("No topic specified to subscribe to.")
                            return
                        }
                        tempSubscription = client.subscribe(topicField.text)
                        tempSubscription.messageReceived.connect(addMessage)
                    }
                }

                ListView {
                    id: messageView
                    model: messageModel
                    implicitHeight: 300
                    implicitWidth: 200
                    Layout.columnSpan: 2
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip: true
                    delegate: Rectangle {
                        id: delegatedRectangle
                        required property int index
                        required property string payload
                        width: ListView.view.width
                        height: 30
                        color: index % 2 ? "#DDDDDD" : "#888888"
                        radius: 5
                        Text {
                            text: delegatedRectangle.payload
                            anchors.centerIn: parent
                        }
                    }
                }

                QQC2.Label {
                    function stateToString(value) {
                        if (value === 0)
                            return "Disconnected"
                        else if (value === 1)
                            return "Connecting"
                        else if (value === 2)
                            return "Connected"
                        else
                            return "Unknown"
                    }

                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    color: "#333333"
                    text: "Status:" + stateToString(client.state) + "(" + client.state + ")"
                    enabled: client.state === MqttClient.Connected
                }


            }

            // Lightswitch Section
            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: connectPanel.bottom
                anchors.bottom: parent.bottom
                anchors.margins: 24
                height: parent.height

                Column {
                    id: lightswitchescol
                    width: parent.width
                    spacing: 16
                    height: 300
                }
            }
        }
    }


}
