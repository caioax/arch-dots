pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Services.UPower

Text {
    id: root
    visible: false   // só aparece quando achar a bateria
    font.pixelSize: 16

    property int capacity: 0
    property int state: UPowerDeviceState.Unknown

    Repeater {
        model: UPower.devices

        delegate: Item {
            required property UPowerDevice modelData
            visible: false

            Component.onCompleted: {
                if (!modelData.isLaptopBattery)
                    return;

                // Ativa o widget
                root.visible = true;

                // Bindings REATIVOS
                root.capacity = Qt.binding(() => Math.round(modelData.percentage * 100));

                root.state = Qt.binding(() => modelData.state);
            }
        }
    }

    color: {
        if (state === UPowerDeviceState.Charging)
            return "#a6e3a1";
        if (capacity < 20)
            return "#f38ba8";
        return "#cdd6f4";
    }

    text: {
        var icon = "";
        if (capacity < 90)
            icon = "";
        if (capacity < 60)
            icon = "";
        if (capacity < 40)
            icon = "";
        if (capacity < 10)
            icon = "";

        if (state === UPowerDeviceState.Charging)
            icon = " " + icon;

        return icon + " " + capacity + "%";
    }
}
