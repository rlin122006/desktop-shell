//@ pragma UseQApplication
import Quickshell
import QtQuick

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panelWindow

            anchors {
                top: true
                left: true
                right: true
            }

            implicitWidth: Screen.width
            implicitHeight: 32

            color: "transparent"

            Rectangle {
                id: rectangle

                width: parent.width
                height: parent.height

                color: "transparent"

                anchors.centerIn: parent

                Row {
                    id: leftRow
                    spacing: 4

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 0
                    }

                    Logo {}

                    Workspaces {
                        screen: panelWindow.screen
                    }
                }

                Row {
                    id: rightRow
                    spacing: 16

                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: 0
                    }

                    SystemTray {}

                    Battery {}

                    Connection {}

                    Clock {}
                }
            }
        }
    }
}
