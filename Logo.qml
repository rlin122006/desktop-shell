import QtQuick

Image {
    source: "./Assets/nixos-logomark.svg"
    width: 36
    height: 36

    anchors {
        verticalCenter: parent.verticalCenter
    }

    sourceSize: Qt.size(256, 256)
    fillMode: Image.PreserveAspectFit
}
