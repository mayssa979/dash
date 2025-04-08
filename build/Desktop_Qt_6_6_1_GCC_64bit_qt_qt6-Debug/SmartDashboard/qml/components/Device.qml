import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.example.messages 1.0
/*Item {
    width: 800
    height: 600

        Rectangle {
        anchors.fill: parent
        color: "#002147"
        z: -1
        RowLayout {
            anchors.fill: parent
            spacing: 2
            Text {
                id: title
                text: "LORA GATEWAY DASHBOARD"
                font.family: "Serif"
                font.pixelSize: 36
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
                color: "#B0C4DE"
            }
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 20
                Rectangle {
                    width: 80
                    height: 2
                    color: "#708090"
                }
                Rectangle {
                    width: 80
                    height: 2
                    color: "#708090"
                }
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                id: backButton
                Layout.columnSpan: 2
                Layout.fillWidth: true
                text: "\u2190 Back"
                onClicked: {
                    pageLoader.source = ""
                    pageLoader.source = "components/RightPane"
                }
            }
        }
        }




            Flickable {
                id: flickable
                anchors.fill: parent
                contentHeight: columnLayout.implicitHeight
                flickableDirection: Flickable.VerticalFlick

                function resetScroll() {
                    contentY = 0
                }
                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AlwaysOn
                }

                RowLayout{
                   // Layout.fillHeight: true
                    Layout.fillWidth: true
                    anchors.fill: parent
                    Item {
                        width: parent.width * 0.25
                       // height: parent.height
                        Sidebar {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                    }
                    Item {
                        width:  parent.width * 0.75
                       // height: parent.height
                        property string selectedMessage: ""
                                ColumnLayout {
                                    id: columnLayout
                                    ColumnLayout {
                                        RowLayout {
                                            Edev { id: edev
                                                deviceName: "Device-" + JSON.stringify(parseMessage())
                                                hum: JSON.stringify(parseHum()) + " %"
                                            }
                                            Edev { id: edev1}
                                            }

                                        RowLayout {
                                            Edev { id: edev2 }
                                            Edev { id: edev3}
                                        }
                                    }
                                }
                        }
                    }
        }



        function parseMessage()
        {
            try {
                var jsonObj = JSON.parse(MessageStore.message)
                console.log("new gateway ", JSON.stringify(jsonObj.edev.id))
                return jsonObj.edev.id
            }catch(e) {
                console.log("JSON parse error! ", e)
            }


        }

        function parseHum()
        {
            try {
                var jsonObj = JSON.parse(MessageStore.message)
                console.log("new gateway ", JSON.stringify(jsonObj.edev.humidity))
                return jsonObj.edev.humidity
            }catch(e) {
                console.log("JSON parse error! ", e)
            }


        }

}*/
Item {
    width: 800
    height: 600

    Rectangle {
        anchors.fill: parent
        color: "#002147"
        z: -1

        ColumnLayout {
            anchors.fill: parent
            spacing: 1

            // Top Row: Back Button and Title
            RowLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                spacing: 20

                Button {
                    id: backButton
                    text: "\u2190 Back"
                    onClicked: {
                        pageLoader.source = ""
                        pageLoader.source = "components/RightPane"
                    }
                }

                Text {
                    id: title
                    text: "LORA GATEWAY DASHBOARD"
                    font.family: "Serif"
                    font.pixelSize: 36
                    font.bold: true
                    color: "#B0C4DE"
                    Layout.alignment: Qt.AlignHCenter
                }
            }

            // Row directly under Title and Back Button

            RowLayout {
                Layout.fillWidth: true
               // Layout.alignment: Qt.AlignTop
                spacing: 1
                Flickable {
                    id: flickable
                    //anchors.fill: parent
                   // contentHeight: columnLayout.implicitHeight
                    flickableDirection: Flickable.VerticalFlick

                    function resetScroll() {
                        contentY = 0
                    }
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOn
                    }
                // Sidebar on the left
                Item {
                    width: parent.width * 0.25
                    Sidebar {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }

                // Edev elements on the right
                Item {
                    width: parent.width * 0.75
                    ColumnLayout {
                        id: columnLayout
                        spacing: 10

                        RowLayout {
                            Edev {
                                id: edev
                                deviceName: "Device-" + JSON.stringify(parseMessage())
                                hum: JSON.stringify(parseHum()) + " %"
                            }
                            Edev { id: edev1 }
                        }

                        RowLayout {
                            Edev { id: edev2 }
                            Edev { id: edev3 }
                        }
                    }
                }
            }
            }
        }
    }

    // Parsing functions
    function parseMessage() {
        try {
            var jsonObj = JSON.parse(MessageStore.message)
            return jsonObj.edev.id
        } catch (e) {
            console.log("JSON parse error! ", e)
        }
    }

    function parseHum() {
        try {
            var jsonObj = JSON.parse(MessageStore.message)
            return jsonObj.edev.humidity
        } catch (e) {
            console.log("JSON parse error! ", e)
        }
    }
}
