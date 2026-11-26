import Quickshell.Io
import QtQuick
import QtQuick.Effects

Item {
    id: item
    property string mainInterfaceStatus: "unknown"
    property string wg0InterfaceStatus: "unknown"
    property string wg1InterfaceStatus: "unknown"
    property string wg2InterfaceStatus: "unknown"

    anchors.verticalCenter: parent.verticalCenter

    width: 15
    height: 15

    Image {
        id: wifiIcon
        source: item.connectionIcon(item.mainInterfaceStatus, item.wg0InterfaceStatus, item.wg1InterfaceStatus, item.wg2InterfaceStatus)

        anchors.fill: parent
        visible: false

        sourceSize: Qt.size(256, 256)
        fillMode: Image.PreserveAspectFit
    }

    MultiEffect {
        anchors.fill: wifiIcon
        source: wifiIcon
        brightness: 1.0
        colorization: 1.0
        colorizationColor: Theme.textColor
    }

    // check interfaces every 5 seconds
    Timer {
        interval: 6000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            mainInterfaceCheck.running = true
            wg0InterfaceCheck.running = true
            wg1InterfaceCheck.running = true
            wg2InterfaceCheck.running = true
        }
    }

    // check main wifi interace connection
    Process {
        id: mainInterfaceCheck
        command: ["cat", "/sys/class/net/wlp99s0/operstate"]

        stdout: SplitParser {
            onRead: data => {item.mainInterfaceStatus = data.trim()}
        }
    }

    // check vpn 0
    Process {
        id: wg0InterfaceCheck
        command: ["systemctl", "is-active", "wg-quick-wg0"]
        stdout: SplitParser {
            onRead: data => {item.wg0InterfaceStatus = data.trim()}
        }
    }

    // check vpn 1
    Process {
        id: wg1InterfaceCheck
        command: ["systemctl", "is-active", "wg-quick-wg1"]
        stdout: SplitParser {
            onRead: data => {item.wg1InterfaceStatus = data.trim()}
        }
    }

    // check vpn 2
    Process {
        id: wg2InterfaceCheck
        command: ["systemctl", "is-active", "wg-quick-wg2"]
        stdout: SplitParser {
            onRead: data => {item.wg2InterfaceStatus = data.trim()}
        }
    }

    function connectionIcon(mainInterfaceStatus, wg0InterfaceStatus, wg1InterfaceStatus, wg2InterfaceStatus) {
        if (wg0InterfaceStatus == "active" || wg1InterfaceStatus == "active" || wg2InterfaceStatus == "active") {
            return "./Assets/wifi-lock.svg"
        }
        else if (mainInterfaceStatus === "up") {
            return "./Assets/wifi.svg"
        }
        else if (mainInterfaceStatus === "down") {
            return "./Assets/wifi-off.svg"
        }

        return "./Assets/wifi-strength-alert-outline.svg"
    }
}
