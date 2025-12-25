import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.config
import qs.services

ColumnLayout {
    id: root
    spacing: 10

    // Sinal para voltar ao menu principal
    signal backRequested

    // --- Cabeçalho ---
    RowLayout {
        Layout.fillWidth: true
        spacing: 5

        // Botão Voltar
        Button {
            background: null
            contentItem: Text {
                text: "◀"
                color: Config.textColor
                font.bold: true
                font.pixelSize: 18
            }
            onClicked: root.backRequested()
        }

        Text {
            text: "BluetoothService"
            color: Config.textColor
            font.bold: true
            font.pixelSize: 16
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        // Switch On/Off
        Switch {
            checked: BluetoothService.isPowered
            onToggled: BluetoothService.togglePower()
        }
    }

    // --- Botão de Escanear ---
    Button {
        visible: BluetoothService.isPowered
        text: BluetoothService.isDiscovering ? "Parar Busca..." : "Procurar Dispositivos"
        Layout.fillWidth: true
        Layout.preferredHeight: 30

        background: Rectangle {
            color: Config.surface1Color
            radius: 5
        }
        contentItem: Text {
            text: parent.text
            color: Config.textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        onClicked: BluetoothService.toggleScan()
    }

    // --- Lista de Dispositivos ---
    ListView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        spacing: 5

        // Pega a lista do serviço
        model: BluetoothService.devicesModel

        delegate: Rectangle {
            width: ListView.view.width
            height: 50
            color: modelData.connected ? Config.accentColor : "transparent"
            radius: 5
            border.width: 1
            border.color: Config.surface2Color

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 10

                // Ícone (Tentativa de fallback se iconName falhar)
                Text {
                    text: getIcon(modelData.iconName || "device")
                    font.pixelSize: 18
                    color: modelData.connected ? "#FFF" : Config.textColor
                }

                // Nomes e Endereço
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 0

                    // Alias é o nome amigável, Name é o nome técnico
                    Text {
                        text: modelData.alias || modelData.name || modelData.address
                        color: modelData.connected ? "#FFF" : Config.textColor
                        font.bold: true
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                    Text {
                        text: modelData.address
                        color: modelData.connected ? "#EEE" : Config.surface2Color
                        font.pixelSize: 10
                    }
                }

                // Ícone de status conectado
                Text {
                    text: "✓"
                    visible: modelData.connected
                    color: "#FFF"
                    font.bold: true
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: BluetoothService.connectDevice(modelData)
            }
        }

        // Mensagem se a lista estiver vazia
        Text {
            anchors.centerIn: parent
            visible: parent.count === 0 && BluetoothService.isPowered
            text: "Nenhum dispositivo encontrado."
            color: Config.surface2Color
            font.italic: true
        }
    }

    // Helper simples para ícones
    function getIcon(name) {
        if (name.includes("headset") || name.includes("audio"))
            return "🎧";
        if (name.includes("mouse"))
            return "🖱️";
        if (name.includes("keyboard"))
            return "⌨️";
        if (name.includes("phone"))
            return "📱";
        if (name.includes("computer"))
            return "💻";
        return "🔌";
    }
}
