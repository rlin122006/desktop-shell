pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland

Rectangle {
    id: root

    // Pass the ShellScreen this indicator belongs to when creating the component
    required property var screen

    readonly property var hyprlandMonitor: Hyprland.monitorFor(screen)
    readonly property int activeWorkspaceId: hyprlandMonitor?.activeWorkspace?.id ?? -1

    anchors.verticalCenter: parent.verticalCenter

    implicitWidth: row.implicitWidth
    implicitHeight: 24

    color: "transparent"

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 0

        Repeater {
            model: [1, 2, 3, 4]

            delegate: Rectangle {
                id: rectangle
                required property int modelData

                width: 26
                height: 18
                radius: 9

                color: root.activeWorkspaceId === modelData ? Theme.textColor : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: rectangle.modelData
                    color: root.activeWorkspaceId === rectangle.modelData ? Theme.blackColor : Theme.textColor
                    font.family: Theme.mapleMono
                    font.pixelSize: 14
                }
            }
        }
    }
}
