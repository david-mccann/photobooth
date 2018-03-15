import QtQuick 2.7
import QtQuick.Layouts 1.3

Item {
    property var photo

    Image {
        anchors.fill: parent

        source: "file:" + photo
        enabled: true
        cache: false

        fillMode: Image.PreserveAspectFit
        sourceSize.width: 800
        sourceSize.height: 480
    }
}
