pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland

Rectangle {
    id: root

    // Pass the ShellScreen this indicator belongs to when creating the component
    required property var screen

    readonly property var hyprlandMonitor: Hyprland.monitorFor(screen)
    readonly property int activeWorkspaceId: hyprlandMonitor?.activeWorkspace?.id ?? -1

    implicitWidth: row.implicitWidth + 16
    implicitHeight: parent.implicitHeight

    color: "#000000"

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 4

        Repeater {
            model: [1, 2, 3, 4]

            delegate: Rectangle {
                id: rectangle
                required property int modelData

                width: 16
                height: 16
                radius: 4

                color: root.activeWorkspaceId === modelData ? Theme.textColor : "#000000"

                Text {
                    anchors.centerIn: parent
                    text: rectangle.modelData
                    color: root.activeWorkspaceId === rectangle.modelData ? "#000000" : Theme.textColor
                    font.family: Theme.mapleMono
                    font.pixelSize: 12
                }
            }
        }
    }
}
