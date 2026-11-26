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

                color: "#54101010"

                anchors.centerIn: parent

                Row {
                    id: leftRow
                    spacing: 8

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 6
                    }

                    Logo {}

                    Workspaces {
                        screen: panelWindow.screen
                    }
                }

                Row {
                    id: rightRow
                    spacing: 18

                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: 12
                    }

                    Battery {}

                    Connection {}

                    Clock {}
                }
            }
        }
    }
}
