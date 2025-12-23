import QtQuick
import qs.services

Text {
    id: root

    // Definição das cores
    readonly property color clrActive: "#cdd6f4"
    readonly property color clrMuted: "#6c7086"
    readonly property color clrError: "#f38ba8"

    font.pixelSize: 16
    font.bold: true

    // Lógica da COR
    color: {
        if (!Audio.sinkReady)
            return clrError;      // Se não tiver áudio (Erro)
        if (Audio.muted)
            return clrMuted;      // Se estiver mutado
        return clrActive;         // Normal
    }

    // Lógica do texto
    text: {
        // Se o áudio não estiver pronto (Pipewire caiu ou sem placa)
        if (!Audio.sinkReady)
            return " Erro";

        if (Audio.muted)
            return " ";

        var icon = " ";
        if (Audio.volume < 0.3)
            icon = " ";
        else if (Audio.volume < 0.6)
            icon = " ";

        return icon + Audio.percentage + "%";
    }

    // Interação como o mouse
    MouseArea {
        anchors.fill: parent

        // UX: Transforma o mouse na "Mãozinha" ao passar por cima
        cursorShape: Qt.PointingHandCursor

        // Aceita botão esquerdo para clique
        acceptedButtons: Qt.LeftButton

        // Lógica do Clique (Mute)
        onClicked: Audio.toggleMute()

        // Lógica do Scroll (Volume)
        onWheel: wheel => {
            // angleDelta.y > 0 significa scroll para CIMA
            if (wheel.angleDelta.y > 0) {
                Audio.increaseVolume();
            } else {
                Audio.decreaseVolume();
            }
        }
    }
}
