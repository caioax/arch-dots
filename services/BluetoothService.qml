pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root

    // Pega o adaptador padrão do sistema. Pode ser null se não houver bluetooth.
    property var adapter: Quickshell.Bluetooth.defaultAdapter

    // Propriedades seguras (retornam false/null se não tiver adaptador)
    readonly property bool isPowered: adapter ? adapter.powered : false
    readonly property bool isDiscovering: adapter ? adapter.discovering : false

    // A lista de dispositivos (QList<BluetoothDevice*>)
    readonly property var devicesModel: adapter ? adapter.devices : []

    // Alternar Energia
    function togglePower() {
        if (adapter) {
            adapter.powered = !adapter.powered;
        } else {
            console.warn("BluetoothService: Nenhum adaptador encontrado para ligar/desligar.");
        }
    }

    // Alternar Busca (Scan)
    function toggleScan() {
        if (adapter) {
            adapter.discovering = !adapter.discovering;
        }
    }

    // Conectar/Desconectar
    function connectDevice(device) {
        if (device) {
            if (device.connected) {
                device.disconnect();
            } else {
                device.connect();
            }
        }
    }
}
