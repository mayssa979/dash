import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    width: 300
    height: 300
            Rectangle {
                anchors.fill: parent
                color: "black"

                GridLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    ColumnLayout {
                        Button {
                            Layout.alignment: Qt.AlignHCenter
                            id: backButton
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            text: "\u2190 Back"
                            onClicked: {
                              pageLoader.source = "components/RightPane"
                            }
                        }
                        RowLayout {
                            Edev { id: edev }
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
