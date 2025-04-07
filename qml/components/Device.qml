import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.example.messages 1.0
Item {
    width: 800
    height: 600



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
        RowLayout{

           anchors.fill: parent



            Rectangle {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "#002147"
                property string selectedMessage: ""


                Flickable {
                    id: flickable
                    anchors.fill: parent
                    clip: true
                    contentHeight: columnLayout.implicitHeight
                    flickableDirection: Flickable.VerticalFlick

                    function resetScroll() {
                        contentY = 0
                    }
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOn
                    }

                    ColumnLayout {
                        id: columnLayout
                        width: parent.width

                        ColumnLayout {
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
                            RowLayout {
                                anchors.right: parent.right
                                Edev { id: edev
                                    deviceName: "Device-" + JSON.stringify(parseMessage())
                                    hum: JSON.stringify(parseHum()) + " %"
                                }


                                Edev { id: edev1}
                            }
                            RowLayout {
                                anchors.right: parent.right
                                Edev { id: edev2 }
                                Edev { id: edev3}
                            }




                        }



                    }
                }


            }

        }

}
