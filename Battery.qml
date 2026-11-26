pragma ComponentBehavior: Bound
import Quickshell.Io
import QtQuick
import QtQuick.Effects

Item {
    id: item

    property int batteryLevel: 0
    property string batteryStatus: "Discharging"

    anchors.verticalCenter: parent.verticalCenter

    width: 16
    height: 16

    Image {
        id: batteryIcon
        source: item.batteryIcon(item.batteryLevel, item.batteryStatus)

        anchors.fill: parent
        visible: false

        sourceSize: Qt.size(256, 256)
        fillMode: Image.PreserveAspectFit
    }

    MultiEffect {
        anchors.fill: batteryIcon
        source: batteryIcon
        brightness: 1.0
        colorization: 1.0
        colorizationColor: Theme.textColor
    }

    // check battery every 30 seconds
    Timer {
        interval: 60000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            capacityCheck.running = true
            statusCheck.running = true
        }
    }

    // checks battery current capacity
    Process {
        id: capacityCheck
        command: ["cat", "/sys/class/power_supply/BAT1/capacity"]
    
        stdout: SplitParser {
            onRead: data => {item.batteryLevel = data.trim()}
        }
    }

    // check battery status for charging
    Process {
        id: statusCheck
        command: ["cat", "/sys/class/power_supply/BAT1/status"]

        stdout: SplitParser {
            onRead: data => {item.batteryStatus = data.trim()}
        }
    }

    // returns battery icon path
    function batteryIcon(batteryLevel) {
        const isPluggedIn = batteryStatus !== "Discharging";
        const prefix = isPluggedIn ? "battery-charging" : "battery";

        if (batteryLevel == 100) {
            return `./Assets/${prefix}.svg`;
        }
        else if (batteryLevel > 90) {
            return `./Assets/${prefix}-90.svg`;
        }
        else if (batteryLevel > 80) {
            return `./Assets/${prefix}-80.svg`;
        }
        else if (batteryLevel > 70) {
            return `./Assets/${prefix}-70.svg`;
        }
        else if (batteryLevel > 60) {
            return `./Assets/${prefix}-60.svg`;
        }
        else if (batteryLevel > 50) {
            return `./Assets/${prefix}-50.svg`;
        }
        else if (batteryLevel > 40) {
            return `./Assets/${prefix}-40.svg`;
        }
        else if (batteryLevel > 30) {
            return `./Assets/${prefix}-30.svg`;
        }
        else if (batteryLevel > 20) {
            return `./Assets/${prefix}-20.svg`;
        }
        else if (batteryLevel > 10) {
            return `./Assets/${prefix}-10.svg`;
        }
        else {
            return `./Assets/${prefix}-outline.svg`;
        }
    }
}
