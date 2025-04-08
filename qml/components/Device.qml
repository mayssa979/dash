/*import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.example.messages 1.0
Item {
    width: 800
    height: 600

        Rectangle {
        anchors.fill: parent
        color: "#002147"
        z: -1
        ColumnLayout {

            spacing: 2
            RowLayout {
                ColumnLayout{
                    Layout.alignment: Qt.AlignTop
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

    RowLayout {

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


            ColumnLayout {
                Layout.preferredWidth: parent.width * 0.25
                height: parent.height
                Sidebar {
                Layout.preferredHeight: parent.height}
            }
            ColumnLayout{
                Layout.preferredWidth:  parent.width * 0.75
                Layout.alignment: Qt.AlignRight
                height: parent.height
                property string selectedMessage: ""
                ColumnLayout {
                    id: columnLayout
                    ColumnLayout{
                        RowLayout {
                            Edev{ id: edev
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
    }}
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
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.example.messages 1.0

Item {
    width: 950
    height: 600

    Rectangle {
        anchors.fill: parent
        color: "#002147"
        z: -1

        Item {
            anchors.fill: parent

            // First row: Title and Button
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
                    anchors.verticalCenter: parent.verticalCenter
                }


            }

            // Second row: Sidebar and Edev
            Row {
                spacing: 10
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: tit.bottom
                anchors.topMargin: 20
                anchors.left: parent.left
                anchors.right: parent.right

                Column {
                    id: sidebarContainer
                   // width: parent.width * 0.25
                    height: parent.height
                    anchors.left: parent.left

                    Sidebar {}
                }
                Flickable {
                    id: flickableEdev
                    width: parent.width * 0.75
                    height: parent.height
                    anchors.right: parent.right
                    contentHeight: columnLayoutEdev.implicitHeight
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
        }
    }

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
}
