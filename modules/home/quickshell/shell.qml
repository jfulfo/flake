import Quickshell
import Quickshell.Hyprland
import QtQuick

ShellRoot {
    Theme { id: theme }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 34
            color: theme.base00

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6

                Repeater {
                    model: Hyprland.workspaces

                    delegate: Rectangle {
                        required property var modelData
                        width: 22
                        height: 22
                        radius: 6
                        color: modelData.active ? theme.accent : theme.base02

                        Text {
                            anchors.centerIn: parent
                            text: modelData.id
                            color: modelData.active ? theme.base00 : theme.base05
                        }
                    }
                }
            }

            Text {
                anchors.centerIn: parent
                text: Qt.formatDateTime(clock.date, "ddd  HH:mm")
                color: theme.base05
                font.pixelSize: 14
            }
        }
    }
}
