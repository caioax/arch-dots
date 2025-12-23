import Quickshell.Io
import QtQuick

Text {
    text: ""
    color: "#cdd6f4"
    font.pixelSize: 16

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
