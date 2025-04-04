import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    Rectangle {
        id: container
        width: 250
        height: 200
        color: "#0A0F1A"
        radius: 10
        border.color: "#1E2A38"
        border.width: 2

        ColumnLayout {
            anchors.fill: parent
            spacing: 10

            Button {
                id: fetchButton
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: "FETCH GATEWAYS"
                font.bold: true
                background: Rectangle{
                    radius: 10
                    color: "#3A86FF"
                    gradient: Gradient {
                        GradientStop { position: 0.0; color:"#3A86FF" }
                        GradientStop { position: 1.0; color:"#5A98F2" }
                    }
                }
                onClicked: {
                    gatewayModel.append({name: "gateway 001", status: "online"})
                    gatewayModel.append({name: "gateway 002", status: "offline"})
                    gatewayModel.append({name: "gateway 003", status: "online"})
                }
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: {
                    id: gatewayModel
                }
                delegate: Item {
                    width: parent.width
                    height: 40

                    Rectangle {
                        width: parent.width
                        height: parent.height
                        radius: 5
                        color: "#1E2A38"

                        RowLayout {
                            anchors.fill: parent
                            spacing: 10
                            anchors.leftMargin: 10

                            Rectangle {
                                width: 12
                                height: 12
                                radius: 6
                                color: model.status === "online" ? "green" : "red"
                            }

                            Text {
                                text: model.name
                                color: "white"
                                font.bold: true
                            }
                        }
                    }
                }
            }
        }
    }

}
