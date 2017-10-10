import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    id: root

    property int duration: 1000
    signal countdownFinished()

    RowLayout {
        anchors.fill: parent

        Image {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            sourceSize.width: 600
            sourceSize.height: 600
            fillMode: Image.PreserveAspectFit

            enabled: true
            cache: true
            source: "images/smiley.png"

            Timer {
                interval: root.duration; running: true; repeat: false
                onTriggered: {
                    countdownFinished();
                }
            }
        }
    }
}
