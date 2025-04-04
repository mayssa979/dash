import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import QtQuick.Window
import QtLocation
import QtPositioning
Item {
    Plugin {
        id: mapPlugin
        name: "osm"
        parameters: [
            PluginParameter {name: "osm.mapping.providersrepository.disabled"; value: "true" },
            PluginParameter {name: "osm.mapping.host"; value: "https://a.tile.openstreetmap.org/"}
        ]
    }


    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(36.8065, 10.1815)
        zoomLevel: 20
        property alias osmPlugin: mapPlugin
        property geoCoordinate startCentroid
        MapQuickItem {
            id: locationMarker
            anchorPoint.x: markerImage.width /2
            anchorPoint.y: markerImage.height
            coordinate: QtPositioning.coordinate(36.8065, 10.1815)
            sourceItem: Image {
                id: markerImage
                source: "qrc:/SmartDashboard/assets/images/location.png"
                width: 32
                height: 32
            }
        }

        QQC2.Button {
            Layout.alignment: Qt.AlignLeft
            id: backButton
            Layout.columnSpan: 2
            Layout.fillWidth: true
            text: "\u2190 Back"
            onClicked: {
              pageLoader.source = "components/Device.qml"
            }
        }
        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
            }
            onScaleChanged: (delta) => {
                map.zoomLevel += Math.log2(delta)
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            onRotationChanged: (delta) => {
                map.bearing -= delta
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        WheelHandler {
            id: wheel
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }
        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }
    }
}
