import QtQuick

Rectangle {
    width: 24
    height: 23
    color: tapLauncher.pressed ? "#3b3b3b" : "transparent" // Efeito visual ao clicar
    radius: 5

    Text {
        anchors.centerIn: parent
        text: "" // Ícone do Arch (requer Nerd Font)
        color: "#cdd6f4"
        font.pixelSize: 17
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
