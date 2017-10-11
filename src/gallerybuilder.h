#ifndef GALLERYBUILDER_H
#define GALLERYBUILDER_H

#include <atomic>

#include <QFutureWatcher>
#include <QList>
#include <QObject>

#include "photo.h"

class GalleryBuilder : public QObject {
  Q_OBJECT

public:
  GalleryBuilder();

  Q_INVOKABLE void makeGallery(const QList<QString> &paths);

signals:
  void done(const Photo &photo);

private slots:
  void futureFinished();

private:
  QFutureWatcher<void> *m_watcher;
  Photo m_photo;
};

#endif // GALLERYBUILDER_H
