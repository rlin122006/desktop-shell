//@ pragma UseQApplication
import Quickshell
import QtQuick
import QtQuick.Shapes

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panel

            anchors {
                top: true
                left: true
                right: true
            }

            implicitWidth: Screen.width
            implicitHeight: 28

            color: "transparent"

            Shape {
                id: notch

                property real cornerRadius: 8

                width: row.implicitWidth + cornerRadius * 2
                height: 28

                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }

                Row {
                    id: row

                    width: implicitWidth

                    anchors {
                        top: parent.top
                        topMargin: 4
                        horizontalCenter: parent.horizontalCenter
                    }

                    Workspaces {
                        screen: panel.screen
                    }

                    Clock {}
                }

                ShapePath {
                    fillColor: "#000000"
                    strokeColor: "transparent"

                    startX: 0
                    startY: 0

                    // Top edge
                    PathLine {
                        x: notch.width
                        y: 0
                    }

                    // Inward-curving top-right corner
                    PathCubic {
                        control1X: notch.width - notch.cornerRadius * 0.55228475
                        control1Y: 0
                        control2X: notch.width - notch.cornerRadius
                        control2Y: notch.cornerRadius * 0.44771525

                        x: notch.width - notch.cornerRadius
                        y: notch.cornerRadius
                    }

                    // Right edge
                    PathLine {
                        x: notch.width - notch.cornerRadius
                        y: notch.height - notch.cornerRadius
                    }

                    // Normal rounded bottom-right corner
                    PathCubic {
                        control1X: notch.width - notch.cornerRadius
                        control1Y: notch.height - notch.cornerRadius * 0.44771525
                        control2X: notch.width - notch.cornerRadius * 1.44771525
                        control2Y: notch.height

                        x: notch.width - notch.cornerRadius * 2
                        y: notch.height
                    }

                    // Bottom edge
                    PathLine {
                        x: notch.cornerRadius * 2
                        y: notch.height
                    }

                    // Normal rounded bottom-left corner
                    PathCubic {
                        control1X: notch.cornerRadius * 1.44771525
                        control1Y: notch.height
                        control2X: notch.cornerRadius
                        control2Y: notch.height - notch.cornerRadius * 0.44771525

                        x: notch.cornerRadius
                        y: notch.height - notch.cornerRadius
                    }

                    // Left edge
                    PathLine {
                        x: notch.cornerRadius
                        y: notch.cornerRadius
                    }

                    // Inward-curving top-left corner
                    PathCubic {
                        control1X: notch.cornerRadius
                        control1Y: notch.cornerRadius * 0.44771525
                        control2X: notch.cornerRadius * 0.55228475
                        control2Y: 0

                        x: 0
                        y: 0
                    }
                }
            }
        }
    }
}
