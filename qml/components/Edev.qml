import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: edev
    width: 500
    height: 400

    Rectangle {

        anchors.fill: parent
        color: "black"
        border.color: "lightblue"
        border.width: 2
        radius: 10


        ColumnLayout {
            anchors.fill: parent
            spacing: 10
            anchors.margins: 10

            RowLayout {
                Layout.fillWidth: true
                spacing: 10
                Button {
                     Layout.alignment: Qt.AlignLeft
                     id: backButton
                     Layout.columnSpan: 2
                     Layout.fillWidth: true
                     text: "see location"
                     visible: true
                     onClicked: {
                         pageLoader.source = "components/Maps.qml"
                     }
                 }
                Text {
                    text: "Device 1-1"
                    color: "white"
                    font.bold: true
                    Layout.leftMargin: 10

                }
                Item {
                    Layout.fillWidth: true
                }

                RowLayout {
                    spacing: 5


                    Rectangle {
                        id: statusIndicator
                        width: 10
                        height: 10
                        radius: 5
                        color: "green"
                    }
                    Text {
                        id: statusText
                        text: "ONLINE"
                        color: "white"
                    }

                }
            }
            Text {
                text: "Sensors"
                font.bold: true
                color: "white"
            }
            GridLayout {
                columns: 2
                Layout.fillHeight: true
                Layout.fillWidth: true


                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#222"
                    border.color: "lightblue"
                    radius: 5
                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Text {
                            text: "Humidity"
                            color: "white"
                            }
                        Text {
                            text: "45 %"
                            anchors.margins: 5
                            color: "white"
                            font.bold: true
                        }

                    }


                }


                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#222"
                    border.color: "lightblue"
                    radius: 5

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Text {
                            text: "Temperature"
                            color: "white"
                            }
                        Text {
                            text: "22 °C"
                            color: "white"
                            font.bold: true
                        }

                    }

                }


                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#222"
                    border.color: "lightblue"
                    radius: 5

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Text {
                            text: "Pressure"
                            color: "white"
                            }
                        Text {
                            text: "992 hPa"
                            color: "white"
                            font.bold: true
                        }

                    }

                }


                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#222"
                    border.color: "lightblue"
                    radius: 5

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Text {
                            text: "Light"
                            color: "white"
                            }
                        Text {
                            text: "309 Lux"
                            color: "white"
                            font.bold: true
                        }

                    }

                }
            }
            Text {
                text: "Actuators"
                font.bold: true
                color: "white"
            }

            GridLayout {
                columns: 2
                Layout.fillHeight: true
                Layout.fillWidth: true
                Rectangle {

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#222"
                    border.color: "lightblue"
                    radius: 5
                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Text {
                            text: "Relay 1"
                            color: "white"
                            }
                        Text {
                            text: "ON"
                            anchors.margins: 5
                            color: "white"
                            font.bold: true
                        }
                        Button {
                            id: disbutton
                            property bool isEnabled: false
                            text: "Disable"

                            background: Rectangle {
                                radius: 5
                                color: disbutton.isEnabled ? "#517891" : "red"
                            }

                            onClicked: {
                                disbutton.isEnabled = !disbutton.isEnabled
                                disbutton.text= disbutton.isEnabled ? "Enable" : "Disable"
                            }
                        }

                    }


                }


                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#222"
                    border.color: "lightblue"
                    radius: 5

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Text {
                            text: "Relay 2"
                            color: "white"
                            }
                        Text {
                            text: "OFF"
                            color: "white"
                            font.bold: true
                        }
                        Button {
                            id: disbutton1
                            property bool isEnabled: false
                            text: "Disable"

                            background: Rectangle {
                                radius: 5
                                color: disbutton1.isEnabled ? "#517891" : "red"
                            }

                            onClicked: {
                                disbutton1.isEnabled = !disbutton1.isEnabled
                                disbutton1.text= disbutton1.isEnabled ? "Enable" : "Disable"
                            }
                        }

                    }

                }


                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#222"
                    border.color: "lightblue"
                    radius: 5

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Text {
                            text: "Valve"
                            color: "white"
                            }
                        Text {
                            text: "34 %"
                            color: "white"
                            font.bold: true
                        }

                        Button {
                            id: disbutton2
                            property bool isEnabled: false
                            text: "Disable"

                            background: Rectangle {
                                radius: 5
                                color: disbutton2.isEnabled ? "#517891" : "red"
                            }

                            onClicked: {
                                disbutton2.isEnabled = !disbutton2.isEnabled
                                disbutton2.text= disbutton2.isEnabled ? "Enable" : "Disable"
                            }
                        }
                    }

                }


                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: "#222"
                    border.color: "lightblue"
                    radius: 5

                    Column {
                        anchors.centerIn: parent
                        spacing: 5
                        Text {
                            text: "Fan"
                            color: "white"
                            }
                        Text {
                            text: "HIGH"
                            color: "white"
                            font.bold: true
                        }

                        Button {
                            id: disbutton3
                            property bool isEnabled: false
                            text: "Disable"

                            background: Rectangle {
                                radius: 5
                                color: disbutton3.isEnabled ? "#517891" : "red"
                            }

                            onClicked: {
                                disbutton3.isEnabled = !disbutton3.isEnabled
                                disbutton3.text= disbutton3.isEnabled ? "Enable" : "Disable"
                            }
                        }

                    }

                }
            }
        }
    }


}
