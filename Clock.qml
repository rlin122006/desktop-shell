import Quickshell
import QtQuick

Rectangle {
    anchors {
        centerIn: parent
    }

    implicitHeight: clockText.implicitHeight
    implicitWidth: clockText.implicitWidth

    color: "transparent"

    Text {
        id: clockText
        anchors.centerIn: parent
        color: Theme.textColor
        font.family: Theme.mapleMono
        text: Qt.formatDateTime(clock.date, "ddd, MMM dd   hh:mm")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
