import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Item {
    property var photo
    property int duration

    signal save()
    signal reject()

    Component.onCompleted: {
        duration = globalSettings.galleryDuration * 1000;
    }

    GridLayout {
        id: gallery
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5
        rows: 2
        columns: 2
        anchors.fill: parent

        Image {
            id: image
            Layout.fillHeight: true
            Layout.fillWidth: true
            fillMode: Image.PreserveAspectFit
            Layout.row: 1
            Layout.column: 1
            Layout.columnSpan: 2
            sourceSize.width: 640
            sourceSize.height: 480
            source: "file:" + photo.path

            MouseArea {
                scale: 1
                anchors.fill: parent
                onClicked: {
                    timer.stop();
                    save();
                }
            }
        }

        /*Button {
            id: saveButton
            enabled: photo !== undefined
            Layout.row: 3
            Layout.column: 1
            font.pointSize: 24
            text: qsTr("Speichern")
            Layout.fillWidth: true
            onClicked: save()
        }

        Button {
            id: rejectButton
            enabled: photo !== undefined
            Layout.row: 3
            Layout.column: 2
            font.pointSize: 24
            text: qsTr("Verwerfen")
            Layout.fillWidth: true
            onClicked: reject()
        }*/

        Timer {
            id: timer
            interval: duration; repeat: false; running: true
            onTriggered: {
                save();
            }
        }
    }

}
