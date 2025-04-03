import QtQuick

Item {
    id: leftItem
    width: 370
    height: parent.height
    anchors.left: parent.left



    Rectangle {
        id: locationitem
        radius: 16
        height: 126
        color: glassyBgColor
        width: parent.width
        anchors.top: parent.top

        Row {
            id: locationitempadded
            anchors.fill: parent
            anchors.margins: 24

            Repeater {
                id: locationrepeater
                model: menuModel

                delegate: Item {
                    id: menudelegateitem
                    height: locationitempadded.height
                    width: locationitempadded.width / locationrepeater.model.count

                    property string label
                    property bool isActive: label===activeMenuLabel
                    property alias icon: iconlabel.icon
                    property alias size: iconlabel.size

                    signal clicked()

                    label: model.label
                    icon: model.icon
                    size: model.size
                    onClicked: activeMenuLabel=label

                    Column {
                        anchors.fill: parent
                        spacing: 8

                        IconLabel {
                            id: iconlabel
                            width: parent.height * 0.5
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: IconLabel.AlignHCenter
                            verticalAlignment: IconLabel.AlignVCenter
                            opacity: menudelegateitem.isActive ? 1 : 0.5

                            Behavior on opacity { NumberAnimation { duration: 300 }}
                        }

                        Text {
                            text: menudelegateitem.label
                            font.pixelSize: 12
                            color: textColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            opacity: menudelegateitem.isActive ? 1 : 0.5

                            Behavior on opacity { NumberAnimation { duration: 300 }}

                            Rectangle {
                                width: parent.parent.width * 0.8
                                height: 4
                                radius: 2
                                color: textColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: -8
                                opacity: menudelegateitem.isActive ? 1 : 0.5

                                Behavior on opacity { NumberAnimation { duration: 300 }}
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: menudelegateitem.clicked()
                    }
                }

            }
        }
    }
}
