import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0

Item {
    property var extraPhoto

    signal finished()

    GridLayout {
        id: gridLayout
        columns: 2
        rows: 2
        anchors.fill: parent

        Component {
            id: photoView
            PhotoView {
                photo: extraPhoto
            }
        }

        Component {
            id: photoCountdown
            PhotoCountdown {
                onCountdownFinished: {
                    extraPhoto = photoCapture.capture();
                    stackView.push(photoView);
                }
            }
        }

        Component {
            id: photoTrigger
            PhotoTrigger {
                onTriggered: {
                    stackView.push(photoCountdown);
                }
            }
        }

        StackView {
            id: stackView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.row: 1
            Layout.column: 1
            Layout.columnSpan: 2
            initialItem: photoTrigger
        }

        Button {
            id: acceptButton
            text: qsTr("Akzeptieren")
            font.pointSize: 24
            Layout.fillWidth: true
            Layout.row: 2
            Layout.column: 1
            enabled: extraPhoto !== undefined
            onClicked: {
                extraPhoto.saveAsExtraPhoto();
                finished();
            }
        }

        Button {
            id: discardButton
            text: qsTr("Wiederholen")
            font.pointSize: 24
            Layout.fillWidth: true
            Layout.row: 2
            Layout.column: 2
            enabled: extraPhoto !== undefined
            onClicked: {
                extraPhoto.remove();
                stackView.clear();
                stackView.push(photoCountdown);
            }
        }
    }
}
