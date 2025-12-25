import QtQuick
import Quickshell
import QtQuick.Layouts
import "../../widgets/"
import qs.config

Rectangle {
    id: root

    width: iconsLayout.implicitWidth + (Config.padding * 4)
    height: Config.barHeight - 10

    radius: height / 2

    color: tapHandler.pressed ? Config.surface2Color : hoverHandler.hovered ? Config.surface1Color : "transparent"

    // Ícones
    RowLayout {
        id: iconsLayout
        anchors.centerIn: parent
        spacing: Config.spacing // Espaço entre os ícones

        Text {
            text: ""

            font.family: Config.font
            font.pixelSize: Config.fontSizeNormal
            font.bold: true

            color: Config.textColor
        } // Wifi

        Text {
            text: ""

            font.family: Config.font
            font.pixelSize: Config.fontSizeNormal
            font.bold: true

            color: Config.textColor
        } // Bluetooth

        Volume {}
    }

    ControlPopup {
        id: controlPopup

        anchor.item: root
        anchor.edges: Edges.Bottom | Edges.Right
        anchor.gravity: Edges.Bottom | Edges.Left
        anchor.rect: Qt.rect(0, 0, root.width, root.height + 10)

        visible: false
    }

    // Interação
    // Detecta o mouse passando por cima (Hover)
    HoverHandler {
        id: hoverHandler
        cursorShape: Qt.PointingHandCursor // Muda o cursor para mãozinho
    }

    // Detecta o clique
    TapHandler {
        id: tapHandler
        onTapped: {
            controlPopup.visible = !controlPopup.visible;
        }
    }
}
