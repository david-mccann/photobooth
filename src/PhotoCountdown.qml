import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: root

    property int value
    property var photo
    signal countdownFinished()

    Component.onCompleted: {
        value = globalSettings.countdownDuration;
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            value--;
            countdownText.text = String(value);
            if (value === 0) {
                stop();
                countdownFinished();
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        Text {
            id: countdownText
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: String(value)
            font.capitalization: Font.AllUppercase
            font.pointSize: 200
            Layout.fillWidth: false
        }
    }
}
