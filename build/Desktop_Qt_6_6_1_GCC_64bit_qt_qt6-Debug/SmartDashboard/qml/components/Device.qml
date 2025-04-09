import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.example.messages 1.0


    Rectangle {
        anchors.fill: parent
        color: "#002147"
        z: -1

        Item {
            anchors.fill: parent

            /***************First row start*************************************/
            Row {
                id:tit
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 10
                Button {
                    id: backButton
                    text: "\u2190 Back"
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: {
                        pageLoader.source = ""
                    }
                }
                Text {
                    id: title
                    text: "LORA GATEWAY DASHBOARD"
                    font.family: "Serif"
                    font.pixelSize: 36
                    font.bold: true
                    color: "#B0C4DE"
                    anchors.verticalCenter: parent.verticalCenter
                }


            }
            /***************first row end*************************************/
            /***************Second row start*************************************/
            Rectangle {
                id:secondRow
                anchors {
                    top: tit.bottom
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 20
                }
                width: parent.width - 20

                Sidebar {}

                Flickable {
                    id: flickableEdev
                    width: secondRow.width * 0.75
                    //height: secondRow.height
                    anchors.right: secondRow.right
                   // contentHeight: columnLayoutEdev.implicitHeight
                    flickableDirection: Flickable.VerticalFlick
                    function resetScroll() {
                        contentY = 0
                    }
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOn
                    }

                    Column {
                        id: columnLayoutEdev
                        spacing: 20

                        Row {
                            spacing: 10
                            Edev {
                                id: edev
                                deviceName: "Device-" + JSON.stringify(parseMessage())
                                hum: JSON.stringify(parseHum()) + " %"
                            }
                                Edev { id: edev1 }
                        }

                        Row {
                            spacing: 10
                            Edev { id: edev2 }
                            Edev { id: edev3 }
                        }
                    }

                }
            }
            /***************Second row end*************************************/
        }

/***************parsing methods start*************************************/
    function parseMessage() {
        try {
            var jsonObj = JSON.parse(MessageStore.message)
            console.log("new gateway ", JSON.stringify(jsonObj.edev.id))
            return jsonObj.edev.id
        } catch (e) {
            console.log("JSON parse error! ", e)
        }
    }

    function parseHum() {
        try {
            var jsonObj = JSON.parse(MessageStore.message)
            console.log("new gateway ", JSON.stringify(jsonObj.edev.humidity))
            return jsonObj.edev.humidity
        } catch (e) {
            console.log("JSON parse error! ", e)
        }
    }
/***************parsing methods end*************************************/
}
