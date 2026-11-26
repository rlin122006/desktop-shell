//@ pragma UseQApplication
import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

Row {
    id: tray
    anchors {
        verticalCenter: parent.verticalCenter
    }

    spacing: 16

    Repeater {
        model: SystemTray.items

        delegate: Item {
            id: trayEntry

            required property var modelData

            width: 16
            height: 16

            Image {
                anchors.fill: parent

                source: trayEntry.modelData.icon
                sourceSize.width: 16
                sourceSize.height: 16

                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            MouseArea {
                anchors.fill: parent

                acceptedButtons:
                    Qt.LeftButton |
                    Qt.RightButton

                onClicked: mouse => {
                    const item = trayEntry.modelData;

                    if (mouse.button === Qt.LeftButton) {
                        if (item.onlyMenu) {
                            openMenu();
                        } else {
                            item.activate();
                        }
                    }

                    else if (mouse.button === Qt.RightButton) {
                        openMenu();
                    }
                }

                function openMenu() {
                    if (!trayEntry.modelData.hasMenu)
                        return;

                    trayMenu.open();
                }
            }

            QsMenuAnchor {
                id: trayMenu

                menu: trayEntry.modelData.menu

                anchor.item: trayEntry
            }
        }
    }
}
