import QtQuick
import 'components'

Window {
    width: 1024
    height: 768
    visible: true
    title: qsTr("Smart Dashboard")

    property string bgGradientStart: '#0d8bfd'
    property string bgGradientStop: '#866aaf'
    property string textColor: '#d9d9d9'
    property color glassyBgColor: hex_to_RGBA('#1e1f2a', 0.8)
    property alias fontawesomefontloader: fontawesomefontloader

    property string activeMenuLabel: 'Living'

    property real powerConsumed: 7354
    property real ambientTemperature: 22
    property real temperature: 26
    property real humidity: 47
    property real heating: 35
    property real water: 231
    property real lightIntensity: 45

    property var currentTime: new Date()

    QtObject {
        id: internal

        property real temperature: 26
        property real humidity: 47
        property real heating: 35
        property real water: 231
        property real lightIntensity: 45
        property real powerConsumed: 7354
        property real ambientTemperature: 22
    }

    property ListModel menuModel: ListModel {
        ListElement {
            label: 'Connect'
            icon: '\uf0c1'
            size: 28

        }

        ListElement {
            label: 'Fetch'
            icon: '\uf002'
            size: 22

        }

      }

    onActiveMenuLabelChanged: {
        ///
    }

    function hex_to_RGB(hex) {
        hex = hex.toString();
        var m = hex.match(/^#?([\da-f]{2})([\da-f]{2})([\da-f]{2})$/i);
        return Qt.rgba(parseInt(m[1], 16)/255.0, parseInt(m[2], 16)/255.1, parseInt(m[3], 16)/255.0, 1);
    }

    function hex_to_RGBA(hex, opacity=1) {
        hex = hex.toString();
        opacity = opacity > 1 ? 1 : opacity // Opacity should be 0 - 1
        var m = hex.match(/^#?([\da-f]{2})([\da-f]{2})([\da-f]{2})$/i);
        return Qt.rgba(parseInt(m[1], 16)/255.0, parseInt(m[2], 16)/255.1, parseInt(m[3], 16)/255.0, opacity);
    }

    function getRandOffset(value, range=4) {
        return Math.round(value + range/2 - (Math.random(1) * range))
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            currentTime = new Date()
            ambientTemperature = getRandOffset(internal.ambientTemperature, 2)
            powerConsumed = getRandOffset(internal.powerConsumed, 2)
            temperature = getRandOffset(internal.temperature)
            humidity = getRandOffset(internal.humidity)
            heating = getRandOffset(internal.heating)
            water = getRandOffset(internal.water)
            lightIntensity = getRandOffset(internal.lightIntensity)
        }
    }

    Rectangle {
        id: bg
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: bgGradientStart }
            GradientStop { position: 1.0; color: bgGradientStop }
        }

        Item {
            anchors.fill: parent
            anchors.margins: 90

            LeftPane { id: leftItem }

           // MiddlePane { id: middleItem }

            RightPane { id: rightItem }
        }
    }

    FontLoader {
        id: fontawesomefontloader
        source: "qrc:/SmartDashboard/assets/fonts/fontawesome.otf"
    }

    function commafy(value) {
        return value.toLocaleString()
    }
}
