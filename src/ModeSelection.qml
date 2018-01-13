import QtQuick 2.4
import QtQuick.Layouts 1.3

Item {
    signal fourImageModeSelected()
    signal threeImageModeSelected()

    RowLayout {
        anchors.fill: parent

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                enabled: true
                //antialiasing: true
                fillMode: Image.Pad
                sourceSize.width: 400
                sourceSize.height: 400
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

            Text {
                text: "4er"
                font.pointSize: 50
                Layout.alignment: Qt.AlignHCenter
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

            Image {
                enabled: true
                //antialiasing: true
                fillMode: Image.Pad
                sourceSize.width: 400
                sourceSize.height: 400
                source: "images/3.png"

                MouseArea {
                    id: threeImageArea
                    anchors.fill: parent
                    onClicked: {
                        threeImageModeSelected();
                    }
                }
            }

            Text {
                text: "3er + 1"
                font.pointSize: 50
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
