import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.config

PopupWindow {
    id: root

    // Defina o tamanho fixo da sua janela
    implicitWidth: 400
    implicitHeight: 400

    color: "transparent"

    HyprlandFocusGrab {
        id: focusGrab

        windows: [root]

        active: root.visible

        onCleared: {
            root.visible = false;
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Config.backgroundColor
        radius: Config.radius
        border.width: 0
        border.color: Config.surface2Color
        clip: true

        StackLayout {
            id: pageStack
            anchors.fill: parent
            anchors.margins: 10
            currentIndex: 0 // 0 = Menu Principal

            // --- PÁGINA 0: MENU PRINCIPAL (Grid de Botões) ---
            ColumnLayout {
                spacing: 10

                Text {
                    text: "Quick Settings"
                    font.bold: true
                    color: Config.textColor
                    Layout.alignment: Qt.AlignHCenter
                }

                // Exemplo de layout em grade para os botões
                GridLayout {
                    columns: 2
                    Layout.fillWidth: true

                    // Botão WI-FI
                    QuickTile {
                        icon: "  "
                        label: "Wi-Fi"
                        active: true // Lógica real viria aqui

                        onToggled: active = !active
                        // AQUI ESTÁ A MÁGICA: Muda o index do stack
                        onOpenDetails: pageStack.currentIndex = 1
                    }

                    // Botão BLUETOOTH
                    QuickTile {
                        icon: "󰂯 "
                        label: "Bluetooth"
                        active: false

                        onToggled: active = !active
                        onOpenDetails: pageStack.currentIndex = 2
                    }

                    // Outros botões (ex: Modo Escuro, sem detalhes)
                    QuickTile {
                        icon: "󰽥 "
                        label: "Dark"
                        hasDetails: false
                        onToggled: active = !active
                    }
                }

                // Espaço vazio para empurrar tudo pra cima
                Item {
                    Layout.fillHeight: true
                }
            }

            // Wifi
            WifiPage {
                onBackRequested: pageStack.currentIndex = 0
            }

            // Bluetooth
            BluetoothPage {
                onBackRequested: pageStack.currentIndex = 0
            }
        }
    }
}
