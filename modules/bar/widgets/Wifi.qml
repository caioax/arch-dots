import Quickshell.Io
import QtQuick
import qs.config

Text {
    text: ""

    font.family: Config.font
    font.pixelSize: Config.fontSizeNormal
    font.bold: true

    color: Config.textColor

    Process {
        id: rofiMenu
        command: ["sh", "-c", "~/.config/waybar/scripts/rofi-wifi-menu.sh"]
    }

    TapHandler {
        cursorShape: Qt.PointingHandCursor
        onTapped: {
            rofiMenu.running = true;
        }
    }
}
