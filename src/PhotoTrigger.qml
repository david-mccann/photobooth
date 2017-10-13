import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    signal triggered()

    RowLayout {
        anchors.fill: parent

        Image {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            sourceSize.width: 600
            sourceSize.height: 600
            fillMode: Image.PreserveAspectFit

            enabled: true
            cache: true
            source: "images/triggerbutton.png"

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    triggered();
                }
            }
        }
    }
}
