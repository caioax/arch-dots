import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    id: root

    spacing: 3

    readonly property int widthSize: 19
    readonly property int heightSize: 19
    readonly property int widthSizeActive: 30
    readonly property int heightSizeActive: 20

    // 1. Pega o ID atual (se for nulo, assume 1)
    readonly property int currentId: Hyprland.focusedWorkspace?.id ?? 1

    // Calcula onde a lista deve começar
    property int startId: 1

    Repeater {
        model: 10

        delegate: Rectangle {
            id: workspaceItem

            Layout.alignment: Qt.AlignVCenter
            radius: 10

            // Tentamos pegar o objeto real do workspace na memória do Hyprland
            property var wsObject: Hyprland.workspaces.values.find(ws => ws.id === workspaceId)

            // Verifica se o workspace esta vazio
            property bool isEmpty: wsObject === undefined

            // Pega o id da workspace atual
            property int workspaceId: root.startId + index

            // Verifica se este workspace (workspace) é o focado (Hyprland.focusedWorkspace)
            property bool isActive: Hyprland.focusedWorkspace && workspaceId === Hyprland.focusedWorkspace.id

            // Escolhe o tamanho correto para o widget
            property int realWidth: isActive ? root.widthSizeActive : root.widthSize
            property int realHeight: isActive ? root.heightSizeActive : root.heightSize

            readonly property bool visibleState: isVisible()
            color: isActive ? "#7d9bba" : isEmpty ? "#313244" : "#5e6d7e"
            clip: true

            Layout.preferredWidth: visibleState ? realWidth : 0
            Layout.preferredHeight: visibleState ? realHeight : 0

            // Verificas quais workspaces devem estar visiveis
            function isVisible(): bool {
                // Limite inferion: Foco - 2 (Ex: Se foco 4, mostra a partir do 2)
                var minVisible = root.currentId - 2;
                // Limite superior: Foco + 2 (Ex: Se foco 4, mostra até o 6)
                var maxVisible = root.currentId + 2;

                if (root.currentId < 3) {
                    minVisible = 1;
                    maxVisible = 5;
                } else if (root.currentId > 8) {
                    minVisible = 6;
                    maxVisible = 10;
                }

                return workspaceId >= minVisible && workspaceId <= maxVisible;
            }

            HoverHandler {
                onHoveredChanged: {
                    workspaceItem.opacity = hovered && !workspaceItem.isActive ? 0.7 : 1.0;
                }
            }

            // Animações
            Behavior on color {
                ColorAnimation {
                    duration: 300
                }
            }

            Behavior on Layout.preferredWidth {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 120
                }
            }

            // O número do workspace
            Text {
                anchors.centerIn: parent
                text: workspaceItem.workspaceId
                color: (workspaceItem.isActive || !workspaceItem.isEmpty) ? "#11111b" : "#9c9c9c"
                font.pixelSize: workspaceItem.isActive ? 14 : 12
                font.bold: true
            }

            // --- Ação de clique ---
            TapHandler {
                onTapped: {
                    // Envia comando para o Hyprland trocar de workspace
                    Hyprland.dispatch("workspace " + workspaceItem.workspaceId);
                }
            }
        }
    }
}
