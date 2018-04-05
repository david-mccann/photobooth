import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import PhotoCapture 1.0

Item {
    property var extraPhoto

    signal finished()

    GridLayout {
        id: gridLayout
        columns: 2
        rows: 2
        anchors.fill: parent
        anchors.topMargin: 5

        Component {
            id: photoView
            PhotoView {
                photo: extraPhoto
            }
        }

        Component {
            id: smiley
            Smiley {
                PhotoCapture {
                    id: photoCapture
                    onFinished: {
                        console.log("Captured: ", path);
                        extraPhoto = path;
                        stackView.push(photoView);
                    }
                }

                Component.onCompleted: {
                    photoCapture.captureExtra();
                }
            }
        }

        Component {
            id: photoCountdown

            PhotoCountdown {
                onCountdownFinished: {
                    stackView.replace(null, smiley, {}, StackView.Immediate);
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
        }

        Button {
            id: acceptButton
            text: extraPhoto == undefined ? qsTr("Aufnehmen") : qsTr("Übernehmen")
            font.pointSize: 24
            Layout.fillWidth: true
            Layout.minimumHeight: 150
            Layout.row: 2
            Layout.column: 1
            onClicked: {
                if (extraPhoto == undefined) {
                    stackView.replace(null, photoCountdown, {}, StackView.Immediate);
                } else {
                    finished();
                }
            }
        }

        Button {
            id: discardButton
            text: qsTr("Wiederholen")
            font.pointSize: 24
            Layout.fillWidth: true
            Layout.minimumHeight: 150
            Layout.row: 2
            Layout.column: 2
            enabled: extraPhoto !== undefined
            onClicked: {
                stackView.replace(null, photoCountdown, {}, StackView.Immediate);
            }
        }
    }
}
