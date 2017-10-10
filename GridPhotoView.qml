import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Item {
    property var photoList: []

    signal save()
    signal reject()

    GridLayout {
        id: gridLayout
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.topMargin: 5
        columnSpacing: 5
        rowSpacing: 5
        rows: 3
        columns: 2
        anchors.fill: parent

        Image {
            id: image
            Layout.fillHeight: true
            Layout.fillWidth: true
            fillMode: Image.PreserveAspectFit
            Layout.row: 1
            Layout.column: 1
            sourceSize.width: 640
            sourceSize.height: 480
            source: "file:" + photoList[0].path
        }

        Image {
            id: image1
            Layout.fillHeight: true
            Layout.fillWidth: true
            fillMode: Image.PreserveAspectFit
            Layout.row: 1
            Layout.column: 2
            sourceSize.width: 640
            sourceSize.height: 480
            source: "file:" + photoList[1].path
        }

        Image {
            id: image2
            Layout.fillHeight: true
            Layout.fillWidth: true
            fillMode: Image.PreserveAspectFit
            Layout.row: 2
            Layout.column: 1
            sourceSize.width: 640
            sourceSize.height: 480
            source: "file:" + photoList[2].path
        }

        Image {
            id: image3
            Layout.fillHeight: true
            Layout.fillWidth: true
            fillMode: Image.PreserveAspectFit
            sourceSize.width: 640
            sourceSize.height: 480
            Layout.row: 2
            Layout.column: 2
            source: "file:" + photoList[3].path
        }

        Button {
            id: saveButton
            Layout.row: 3
            Layout.column: 1
            font.pointSize: 24
            text: qsTr("Speichern")
            Layout.fillWidth: true
            onClicked: save()
        }

        Button {
            id: rejectButton
            Layout.row: 3
            Layout.column: 2
            font.pointSize: 24
            text: qsTr("Verwerfen")
            Layout.fillWidth: true
            onClicked: reject()
        }
    }

}
