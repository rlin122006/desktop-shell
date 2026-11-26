import Quickshell
import QtQuick

Rectangle {
    implicitHeight: clockText.implicitHeight
    implicitWidth: clockText.implicitWidth

    anchors.verticalCenter: parent.verticalCenter

    color: "transparent"

    Text {
        id: clockText
        anchors.centerIn: parent
        color: Theme.textColor
        font.family: Theme.mapleMono
        font.pixelSize: 14
        text: Qt.formatDateTime(clock.date, "hh:mm | ddd MMM dd ")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
