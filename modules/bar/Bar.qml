import Quickshell
import QtQuick
import QtQuick.Layouts
import "./widgets/"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            // --- CONFIGURAÇÃO DA BARRA ---
            implicitHeight: 30
            color: "transparent"
            screen: modelData

            // Overlay garante que fique sobre jogos/fullscreen
            // WlrLayershell.layer: WlrLayer.Overlay

            // Define o modo de exclusão
            exclusionMode: enableAutoHide ? ExclusionMode.Ignore : ExclusionMode.Normal

            // Garante o tamanho da área reservada quando em modo Normal
            exclusiveZone: enableAutoHide ? 0 : height

            anchors {
                top: true
                left: true
                right: true
            }

            // --- LÓGICA DE AUTOHIDE ---
            // Se o mouse estiver em cima, margem é 0 (mostra tudo).
            // Se não, margem é -29 (esconde, deixando 1px no topo para pegar o mouse).
            margins.top: enableAutoHide ? mouseSensor.hovered ? 0 : (-1 * (height - 1)) : 0

            property bool enableAutoHide: false

            // Animação suave no movimento da janela
            Behavior on margins.top {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutExpo
                }
            }

            // --- SENSOR DE MOUSE ---
            // Cobre toda a janela. Como a janela nunca "some" (só sai da tela),
            // o pedacinho de 1px que sobra ainda detecta o mouse.
            HoverHandler {
                id: mouseSensor
            }

            Rectangle {
                id: barContent
                anchors.fill: parent
                color: "#141414"

                // --- ESQUERDA ---
                RowLayout {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 15

                    LauncherIcon {} // Widget do launcher
                    Workspaces {} // Widget dos Workspaces
                }

                // --- CENTRO ---
                RowLayout {
                    anchors.centerIn: parent
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 15

                    Clock {} // Widget do relógio
                }

                // --- DIREITA ---
                RowLayout {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 15

                    // SystemTray {} // Tray

                    Wifi {} // Widget do Wifi
                    Bluetooth {} // Widget do bluetooth
                    Volume {} // Widget do som
                    Battery {} // Widget da bateria
                }
            }
        }
    }
}
