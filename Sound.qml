import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Effects

Item {
    id: item

    anchors.verticalCenter: parent.verticalCenter

    width: 16
    height: 16

    Image {
        id: soundIcon
        source: (Pipewire.defaultAudioSink?.audio?.muted ?? false) ? "./Assets/volume-off.svg" : "./Assets/volume-high.svg"

        anchors.fill: parent
        visible: false

        sourceSize: Qt.size(256, 256)
        fillMode: Image.PreserveAspectFit
    }

    MultiEffect {
        anchors.fill: soundIcon
        source: soundIcon
        brightness: 1.0
        colorization: 1.0
        colorizationColor: Theme.textColor
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
}
