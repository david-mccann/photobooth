import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    property var photo

    Image {
        anchors.fill: parent

        source: "file:" + photo.path
        enabled: true
        cache: false

        fillMode: Image.PreserveAspectFit
        sourceSize.width: 1024
        sourceSize.height: 574
    }
}
