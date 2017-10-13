import QtQuick 2.4
import QtQuick.Layouts 1.3

Item {
    signal fourImageModeSelected()
    signal threeImageModeSelected()

    RowLayout {
        anchors.fill: parent

        Image {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

            enabled: true
            //antialiasing: true
            fillMode: Image.Pad
            sourceSize.width: 600
            sourceSize.height: 600
            source: "images/4.png"

            MouseArea {
                id: fourImageArea
                scale: 1
                anchors.fill: parent
                onClicked: {
                    fourImageModeSelected();
                }
            }
        }

        Image {
            enabled: true
            //antialiasing: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            fillMode: Image.Pad
            sourceSize.width: 600
            sourceSize.height: 600
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: "images/3.png"

            MouseArea {
                id: threeImageArea
                anchors.fill: parent
                onClicked: {
                    threeImageModeSelected();
                }
            }
        }
    }
}
