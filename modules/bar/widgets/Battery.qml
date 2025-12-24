pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Services.UPower
import qs.services
import qs.config

Text {
    id: root
    font.family: Config.font
    font.pixelSize: Config.fontSizeNormal
    font.bold: true

    visible: false   // só aparece quando achar a bateria

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
            return Config.successColor;
        if (capacity < 20)
            return Config.warningColor;
        return Config.textColor;
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
