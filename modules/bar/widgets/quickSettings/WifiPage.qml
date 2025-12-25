import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.config

ColumnLayout {
    id: root
    spacing: 10

    // Sinal para avisar o Popup que queremos voltar
    signal backRequested

    // Cabeçalho com botão Voltar
    RowLayout {
        Layout.fillWidth: true

        Button {
            text: "<"
            background: Rectangle {
                color: "transparent"
            }
            contentItem: Text {
                text: "<"
                color: Config.textColor
                font.bold: true
                font.pixelSize: 18
            }
            onClicked: root.backRequested()
        }

        Text {
            text: "Redes Wi-Fi"
            color: Config.textColor
            font.bold: true
            font.pixelSize: 16
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        // Switch principal do wifi
        Switch {
            checked: true
        }
    }

    // Lista de redes (Reaproveitando o código anterior)
    ListView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        model: 5 // Mock de 5 redes
        delegate: Text {
            text: "Rede Wi-Fi " + index
            color: Config.textColor
            padding: 10
        }
    }
}
