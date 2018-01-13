import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

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
            onFinished: {
                stackView.replace(null, gallery, {}, StackView.Immediate);
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
                //root.galleryPhoto = undefined;
            }

            onTriggered: {
                stackView.replace(null, photoCountdown);
            }

            onLastGallery: {
                stackView.replace(null, gallery)
            }
        }
    }

    Connections {
        target: galleryBuilder
        onDone: {
            root.galleryPhoto = photo;
            photos.forEach(function(p) { p.saveInSession(); });
            galleryPhoto.saveInSession();
        }
    }

    Component {
        id: smiley
        Smiley {
            Timer {
                interval: 100; repeat: false; running: true
                onTriggered: {
                    var p = photoCapture.capture();
                    console.log(p);
                    photos.push(p);

                    if (mode === "three" && photos.length < 3 || mode === "four" && photos.length < 4) {
                        stackView.replace(null, photoCountdown, {}, StackView.Immediate);
                    } else {
                        var galleryPhotos = [];
                        photos.forEach(function(photo) { galleryPhotos.push(photo); } );

                        if (mode === "three") {
                            galleryPhotos.push(extraPhoto);
                        }

                        var paths = []
                        for(var i in galleryPhotos) {
                            paths.push(galleryPhotos[i].path);
                        }
                        galleryBuilder.makeGallery(paths);

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
