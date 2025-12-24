import QtQuick
import qs.config

Rectangle {
    width: 24
    height: 23
    color: tapLauncher.pressed ? Config.surface1Color : "transparent" // Efeito visual ao clicar
    radius: Config.radiusSmall

    Text {
        anchors.centerIn: parent
        text: "" // Ícone do Arch
        color: Config.textColor
        font.pixelSize: Config.fontSizeLarge
    }

    // O "sensor" de cliques
    TapHandler {
        id: tapLauncher
        onTapped: {
            // Aqui executaremos o comando no futuro.
            console.log("Launcher clicado!");
        }
    }
}
