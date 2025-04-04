import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.example.messages 1.0
Item {
    width: 100
    height: 100

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
            Rectangle {
                anchors.fill: parent
                color: "black"



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
                            /*Text {
                                text: MessageStore.message
                                color: "white"
                            }*/

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
