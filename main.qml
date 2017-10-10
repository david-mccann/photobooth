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

    Component {
        id: photoGrid
        GridPhotoView {
            onSave: {
                photos.forEach(function(photo) { photo.saveInSession(); });
                stackView.replace(null, photoTrigger);
                photos = [];
            }

            onReject: {
                photos.forEach(function(photo) { photo.remove(); });
                stackView.replace(null, photoTrigger);
                photos = [];
            }
        }
    }

    Component {
        id: photoSlideshow
        PhotoSlideshow {
            photos: root.photos
            onFinished: {
                var galleryPhotos = [];
                photos.forEach(function(photo) { galleryPhotos.push(photo); } );

                if (mode === "three") {
                    galleryPhotos.push(extraPhoto);
                }

                // FIXME
                var paths = []
                for(var i in galleryPhotos) {
                  paths.push(galleryPhotos[i].path);
                }
                galleryBuilder.makeGallery(paths);

                stackView.replace(null, photoGrid, { photoList: galleryPhotos });
            }
        }
    }

    Component {
        id: photoCountdown
        PhotoCountdown {
            onCountdownFinished: {
                photos.push(photo);
                console.log(photos);
                stackView.replace(null, smiley, {}, StackView.Immediate);
            }
        }
    }

    Component {
        id: photoTrigger
        PhotoTrigger {
            onTriggered: {
                stackView.replace(null, photoCountdown);
            }
        }
    }

    Component {
        id: smiley
        Smiley {
            onCountdownFinished: {
                if (mode === "three" && photos.length < 3 || mode === "four" && photos.length < 4) {
                    stackView.replace(null, photoCountdown, {}, StackView.Immediate);
                } else {
                    stackView.replace(null, photoSlideshow);
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
