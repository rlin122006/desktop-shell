pragma ComponentBehavior: Bound
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

Shape {
    id: notch

    property real cornerRadius: 8
    width: 224
    height: 32

    anchors {
        top: parent.top
        horizontalCenter: parent.horizontalCenter
    }

    Loader {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        active: !!notch.spotifyPlayer

        sourceComponent: Item {
            Item {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 20
                }
                width: 192
                height: parent.height

                Item {
                    id: marquee

                    anchors {
                        left: parent.left
                        right: playButton.left
                        rightMargin: 4
                        verticalCenter: parent.verticalCenter
                    }
                    height: label.implicitHeight
                    clip: true

                    readonly property string fullText: notch.spotifyPlayer.trackArtist + " - " + notch.spotifyPlayer.trackTitle
                    readonly property real overflow: Math.max(0, label.implicitWidth - width)
                    readonly property bool overflowing: overflow > 0
                    readonly property real speed: 32 // pixels per second
                    property real scrollX: 0

                    function reset() {
                        scrollAnim.stop();
                        scrollX = 0;
                    }

                    function sync() {
                        reset();
                        if (overflowing)
                            scrollAnim.start();
                    }

                    Timer {
                        id: syncTimer
                        interval: 50
                        onTriggered: marquee.sync()
                    }

                    onFullTextChanged: { reset(); syncTimer.restart(); }
                    onWidthChanged: { reset(); syncTimer.restart(); }
                    Component.onCompleted: syncTimer.restart()

                    SequentialAnimation {
                        id: scrollAnim
                        loops: Animation.Infinite

                        PauseAnimation { duration: 1500 } // rest at the start

                        NumberAnimation {
                            target: marquee
                            property: "scrollX"
                            from: 0
                            to: marquee.overflow
                            duration: marquee.overflow / marquee.speed * 1000
                            easing.type: Easing.Linear
                        }

                        PauseAnimation { duration: 1500 }   // rest at the end

                        ScriptAction { script: marquee.scrollX = 0 }   // snap back
                    }

                    Text {
                        id: label
                        x: -marquee.scrollX
                        color: Theme.textColor
                        font.family: Theme.mapleMono
                        font.pixelSize: 12
                        text: marquee.fullText
                        onImplicitWidthChanged: { marquee.reset(); syncTimer.restart(); }
                    }
                }

                ToolButton {
                    id: playButton

                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                    }

                    width: 24
                    height: 24
                    icon.source: notch.spotifyPlayer.isPlaying ? "./Assets/pause.svg" : "./Assets/play.svg"
                    icon.width: 16
                    icon.height: 16
                    icon.color: Theme.textColor

                    onClicked: notch.spotifyPlayer.isPlaying ? notch.spotifyPlayer.pause() : notch.spotifyPlayer.play()

                    background: null
                }
            }
        }
    }

    property var spotifyPlayer: {
        // qmllint disable missing-property
        let players = Mpris.players.values
        // qmllint disable missing-property

        for (let i = 0; i < players.length; i++) {
            let p = players[i]

            if (p.identity.toLowerCase().includes("spotify")) {
                return p
            }
        }

        return null
    }

    property var firefoxPlayer: {
        // qmllint disable missing-property
        let players = Mpris.players.values
        // qmllint disable missing-property

        for (let i = 0; i < players.length; i++) {
            let p = players[i]

            if (p.identity.toLowerCase().includes("mozilla firefox")) {
                return p
            }
        }

        return null
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
