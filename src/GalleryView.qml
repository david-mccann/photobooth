import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Rectangle {
    property var photo
    property int duration

    signal done()

    Component.onCompleted: {
        duration = globalSettings.galleryDuration * 1000;
    }

    color: "black"

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
            sourceSize.width: 800
            sourceSize.height: 480
            source: "file:" + photo
        }

        Timer {
            id: timer
            interval: duration; repeat: false; running: true
            onTriggered: {
                done();
            }
        }
    }

}
