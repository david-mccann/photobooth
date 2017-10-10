import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    property int duration: 3000
    property var photos: []
    property int index: 0

    signal finished()

    RowLayout {
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent

        PhotoView {
            photo: photos[index]

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

            Timer {
                interval: duration; running: true; repeat: true
                onTriggered: {
                    index++;
                    if (index == photos.length) {
                        stop();
                        finished();
                    }
                }
            }
        }
    }
}
