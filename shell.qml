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
            implicitHeight: 24

            color: "transparent"

            Rectangle {
                id: rectangle

                width: parent.width
                height: parent.height

                color: "#54101010"

                anchors.centerIn: parent

                Row {
                    id: leftRow

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 4
                    }

                    Logo {}

                    Workspaces {
                        screen: panelWindow.screen
                    }
                }

                Row {
                    id: rightRow

                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: 8
                    }

                    Clock {}
                }
            }
        }
    }
}
