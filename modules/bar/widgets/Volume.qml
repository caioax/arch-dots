import QtQuick
import qs.services // Assumindo que seu qmldir está configurado como vimos

Text {
    id: root

    // Definição das cores
    readonly property color clrActive: "#cdd6f4"
    readonly property color clrMuted: "#6c7086" // Cinza escuro fica melhor pra mudo
    readonly property color clrError: "#f38ba8" // Vermelho para erro

    font.pixelSize: 16
    font.bold: true // Fica melhor em barras

    // 1. Lógica da COR (Separada!)
    color: {
        if (!Audio.sinkReady)
            return clrError; // Se não tiver áudio (Erro)
        if (Audio.muted)
            return clrMuted;      // Se estiver mutado
        return clrActive;                      // Normal
    }

    // 2. Lógica do TEXTO (Separada!)
    text: {
        // Se o áudio não estiver pronto (Pipewire caiu ou sem placa)
        // Note o "!" (NÃO está pronto)
        if (!Audio.sinkReady)
            return "  Erro";

        if (Audio.muted)
            return "  Mudo";

        var icon = " ";
        if (Audio.volume < 0.3)
            icon = " ";
        else if (Audio.volume < 0.6)
            icon = " ";

        // Adicionei um Math.floor ou round aqui só por segurança visual,
        // mas seu Audio.qml já trata isso no percentage.
        return icon + " " + Audio.percentage + "%";
    }

    // Ação do Mouse
    TapHandler {
        onTapped: Audio.toggleMute()

        // Dica: Scroll para volume!
        // O TapHandler não pega scroll, precisaria de um WheelHandler
    }

    // DICA EXTRA: Scroll no mouse para volume
    WheelHandler {
        onWheel: event => {
            if (event.angleDelta.y > 0)
                Audio.increaseVolume();
            else
                Audio.decreaseVolume();
        }
    }
}
