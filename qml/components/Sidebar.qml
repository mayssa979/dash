import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: sideBar

    width: 105
   // height: parent.height
    state: 'close'
    anchors.left: parent.left
    property bool fetchExpanded: false
    states: [
        State {
            name: 'open'

            PropertyChanges {
                target: sideBar
                width: 270
            }

            PropertyChanges {
                target: timer
                index: 0
            }
        },
        State {
            name: 'close'

            PropertyChanges {
                target: sideBar
                width: 105
            }

            PropertyChanges {
                target: timer
                index: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: 'close'
            to: 'open'

            NumberAnimation {
                properties: 'width'
                duration: 300
                easing.type: Easing.OutCubic
            }

            ScriptAction {
                script: {
                    timer.start();
                }
            }
        },
        Transition {
            from: 'open'
            to: 'close'

            SequentialAnimation {

                ScriptAction {
                    script: {
                        timer.start();
                    }
                }

                PauseAnimation {
                    duration: 600
                }

                NumberAnimation {
                    properties: 'width'
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        }
    ]

    Timer {
        id: timer

        property int index: 0

        interval: 10

        onTriggered: {
            if (sideBar.state == 'open')
                columnItems.itemAt(index).state = 'left';
            else
                columnItems.itemAt(index).state = 'middle';

            if (++index != 3)
                timer.start();
        }
    }

    Rectangle {
        id: body

        radius: 10
        color: '#FFFFFF'
        anchors.fill: parent

        ColumnLayout {
            id: buttonColumn

            width: parent.width
            spacing: 20
            anchors { top: parent.top; topMargin: 30 }

            Repeater {
                id: columnItems

                model: ['Menu', 'Fetch', 'Location']
                delegate: Rectangle {
                    id: button
                    Layout.preferredWidth: 50
                    Layout.preferredHeight:(modelData === "Fetch" && fetchExpanded) ? 180: 50
                    radius: 10
                    color: buttonMouseArea.containsMouse ? '#f0f0f0' : '#ffffff'
                    Layout.alignment: Qt.AlignLeft
                    Layout.topMargin: model.index === 1 ? 20 : 0
                    state: 'middle'

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }

                    Behavior on Layout.preferredHeight  {
                        NumberAnimation
                        {
                            duration: 300
                            easing.type: Easing.InOutQuad
                        }
                    }
                    states: [
                        State {
                            name: 'left'

                            PropertyChanges {
                                target: button
                                Layout.leftMargin: 10
                                Layout.preferredWidth: model.index !== 0 ? 200 : 50
                            }

                            PropertyChanges {
                                target: title
                                opacity: 1
                            }
                        },
                        State {
                            name: 'middle'

                            PropertyChanges {
                                target: button
                                Layout.leftMargin: Math.ceil((sideBar.width - 50) / 2)
                                Layout.preferredWidth: 50
                            }

                            PropertyChanges {
                                target: title
                                opacity: 0
                            }
                        }
                    ]

                    transitions: [
                        Transition {
                            from: 'middle'
                            to: 'left'

                            NumberAnimation {
                                properties: 'Layout.leftMargin, Layout.preferredWidth, opacity'
                                duration: 300
                                easing.type: Easing.InOutSine
                            }
                        },
                        Transition {
                            from: 'left'
                            to: 'middle'

                            NumberAnimation {
                                properties: 'Layout.leftMargin, Layout.preferredWidth, opacity'
                                duration: 300
                                easing.type: Easing.InOutSine
                            }
                        }
                    ]

                    MouseArea {
                        id: buttonMouseArea

                        hoverEnabled: true
                        anchors.fill: parent

                        onClicked: {
                            if (model.index === 0) {
                                if (sideBar.state == 'close')
                                    sideBar.state = 'open';
                                else
                                    sideBar.state = 'close';
                            }else if (model.index === 1){
                              fetchExpanded = !fetchExpanded
                            }
                            else if (model.index === 2){
                              pageLoader.source = "components/Maps.qml"
                            }
                        }
                    }

                    Image {
                        id: icon

                        source: 'qrc:/SmartDashboard/assets/icons/' + modelData + '.svg'
                        sourceSize: Qt.size(30, 30)
                        anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 10 }
                    }

                    Text {
                        id: title

                        text: model.index === 0 ? '' : modelData
                        anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 55 }

                    }

                    Column {
                      id: subButtons
                      anchors {
                        top: title.bottom
                        left: parent.left
                        right: parent.right
                        margins: 10
                      }
                      spacing: 8
                      visible: modelData === "Fetch" && fetchExpanded
                      Button {
                        text: "option1"
                        width: parent.width
                      }

                    }
                }
            }
        }
    }
}
