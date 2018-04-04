import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
//import QtGraphicalEffects 1.0
import InputHandling 1.0

Item {
    property bool hasGalleryPhoto

    signal triggered()
    signal lastGallery()

    Image {
        id: triggerButton

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -38

        fillMode: Image.PreserveAspectFit

        cache: true
        source: "images/triggerbutton.png"

        MaskedMouseArea {
            anchors.fill: parent
            maskSource: triggerButton.source
            onClicked: {
                triggered();
            }
        }
    }

    Image {
        id: lastGalleryButton

        anchors.verticalCenter: triggerButton.verticalCenter
        anchors.horizontalCenter: triggerButton.horizontalCenter
        anchors.verticalCenterOffset: 200
        anchors.horizontalCenterOffset: 177

        fillMode: Image.PreserveAspectFit

        enabled: hasGalleryPhoto

        cache: true
        source: hasGalleryPhoto ? "images/lastgallery.png" : "images/lastgallery_gray.png"

        MaskedMouseArea {
            anchors.fill: parent
            maskSource: lastGalleryButton.source
            onClicked: {
                lastGallery();
            }
        }
    }
}
