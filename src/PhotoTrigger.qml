import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property bool hasGalleryPhoto

    signal triggered()
    signal lastGallery()

    RowLayout {
        anchors.fill: parent

        anchors.bottomMargin: 20
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.topMargin: 20

        Image {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            sourceSize.width: 480
            sourceSize.height: 480
            fillMode: Image.PreserveAspectFit

            enabled: true
            cache: true
            source: "images/triggerbutton.png"

            MouseArea {
                id: triggerMouseArea
                anchors.fill: parent
                onClicked: {
                    triggered();
                }
            }
        }

        Image {
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom

            sourceSize.width: 50
            sourceSize.height: 50
            fillMode: Image.PreserveAspectFit

            visible: hasGalleryPhoto
            cache: true
            source: "images/triggerbutton.png"

            MouseArea {
                id: lastGalleryMouseArea
                anchors.fill: parent
                onClicked: {
                    lastGallery();
                }
            }
        }
    }
}
