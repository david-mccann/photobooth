import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: root

    signal countdownFinished()

    RowLayout {
        anchors.fill: parent
        anchors.margins: 20

        Image {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

            fillMode: Image.PreserveAspectFit

            enabled: true
            cache: true
            source: "images/smiley.png"
        }
    }
}
