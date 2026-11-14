import QtQuick
import QtQuick.Effects

Item {
    id: tile
    property string source: ""
    readonly property real fraction: (cls.proper || cls.square) ? 0.805 : 0.58

    IconClass {
        id: cls
        source: tile.source
    }

    Image {
        id: art
        anchors.fill: parent
        source: tile.source
        sourceSize: Qt.size(128, 128)
        fillMode: Image.PreserveAspectFit
        smooth: true
        mipmap: true
        visible: false
    }

    Rectangle {
        visible: !cls.proper && !cls.square
        anchors.centerIn: parent
        width: parent.width * 0.805
        height: width
        radius: width * 0.245
        color: cls.dom
    }

    MultiEffect {
        anchors.fill: art
        source: art
        scale: tile.fraction / cls.art
        maskEnabled: cls.square
        maskSource: mask
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1.0
    }

    Item {
        id: mask
        width: art.width
        height: art.height
        visible: false
        layer.enabled: true

        Rectangle {
            anchors.fill: parent
            radius: width * 0.245
            color: "black"
        }
    }

    ShaderEffect {
        anchors.centerIn: parent
        width: parent.width * 0.805
        height: width
        property vector2d itemSize: Qt.vector2d(width, height)
        property real cornerR: width * 0.245
        fragmentShader: Qt.resolvedUrl("iconrim.frag.qsb")
    }
}
