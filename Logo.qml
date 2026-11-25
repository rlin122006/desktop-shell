import QtQuick

Image {
    source: "./Assets/nixos-logomark.svg"
    width: 32
    height: 32

    anchors {
        verticalCenter: parent.verticalCenter
    }

    sourceSize: Qt.size(256, 256)
    fillMode: Image.PreserveAspectFit
}
