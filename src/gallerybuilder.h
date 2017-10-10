#ifndef GALLERYBUILDER_H
#define GALLERYBUILDER_H

#include <QFutureWatcher>
#include <QList>
#include <QObject>

#include "photo.h"

class GalleryBuilder : public QObject {
  Q_OBJECT

public:
  GalleryBuilder();

  Q_INVOKABLE void makeGallery(const QList<QString> &paths);

private slots:
  void futureFinished();

private:
  QFutureWatcher<void> *m_watcher;
};

#endif // GALLERYBUILDER_H
