import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import PhotoCapture 1.0


ApplicationWindow {
    id: root

    visible: true
    visibility: Window.FullScreen

    property string mode
    property var photos: []
    property var extraPhoto
    property var galleryPhoto

    Shortcut {
        sequence: "Alt+F4"
        onActivated: {
            root.close();
        }
    }

    Component.onCompleted: {
        root.galleryPhoto = undefined
    }

    Component {
        id: gallery
        GalleryView {
            photo: root.galleryPhoto
            onDone: {
                stackView.replace(null, photoTrigger);
            }
        }
    }

    Component {
        id: photoSlideshow
        PhotoSlideshow {
            photos: root.photos

            Component.onCompleted: {
                galleryBuilder.makeGallery(root.photos)
            }

            onFinished: {
                stackView.replace(null, gallery, {}, StackView.Immediate);
            }

            GalleryBuilder {
                id: galleryBuilder
                onFinished: {
                    console.log("Gallery: ", path);
                    root.galleryPhoto = path;
                }
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

    Component {
        id: photoTrigger
        PhotoTrigger {
            hasGalleryPhoto: root.galleryPhoto !== undefined

            Component.onCompleted: {
                root.photos = [];
            }

            onTriggered: {
                root.photos = [];
                stackView.replace(null, photoCountdown);
            }

            onLastGallery: {
                stackView.replace(null, gallery)
            }
        }
    }

    Component {
        id: smiley
        Smiley {
            Component.onCompleted: {
                photoCapture.capture();
            }

            PhotoCapture {
                id: photoCapture
                onFinished: {
                    console.log("Captured: ", path);
                    root.photos.push(path);

                    if (mode === "three" && root.photos.length < 3 || mode === "four" && root.photos.length < 4) {
                        stackView.replace(null, photoCountdown, {}, StackView.Immediate);
                    } else {
                        if (mode == "three") {
                            root.photos.push(root.extraPhoto);
                        }
                        stackView.replace(null, photoSlideshow);
                    }
                }
            }
        }
    }

    Component {
        id: extraPhotoComponent
        ExtraPhoto {
            onFinished: {
                stackView.replace(null, photoTrigger);
                root.extraPhoto = extraPhoto
            }
        }
    }

    Component {
        id: modeSelection
        ModeSelection {
            onFourImageModeSelected: {
                mode = "four";
                stackView.push(null, photoTrigger);
            }

            onThreeImageModeSelected: {
                mode = "three";
                stackView.push(null, extraPhotoComponent);
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: modeSelection
    }
}
