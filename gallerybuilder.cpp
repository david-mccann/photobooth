#include "gallerybuilder.h"

#include <QDebug>
#include <QFuture>
#include <QImage>
#include <QPainter>
#include <QtConcurrent/QtConcurrent>

#include "settings.h"

GalleryBuilder::GalleryBuilder() : m_watcher(new QFutureWatcher<void>) {
  connect(m_watcher, SIGNAL(finished()), this, SLOT(futureFinished()));
}

void GalleryBuilder::makeGallery(const QList<QString> &paths) {
  QFuture<void> result = QtConcurrent::run(QThreadPool::globalInstance(), [=] {
    const int imageWidth = 2440;
    const int imageHeight = 1680;

    QImage gallery(imageWidth, imageHeight, QImage::Format_RGB32);
    QPainter painter(&gallery);
    {
      QImage image(paths[0]);
      image = image.scaledToWidth(imageWidth / 2, Qt::SmoothTransformation);
      painter.drawImage(0, 0, image);
    }
    {
      QImage image(paths[1]);
      image = image.scaledToWidth(imageWidth / 2, Qt::SmoothTransformation);
      painter.drawImage(imageWidth / 2, 0, image);
    }
    {
      QImage image(paths[2]);
      image = image.scaledToWidth(imageWidth / 2, Qt::SmoothTransformation);
      painter.drawImage(0, imageHeight / 2, image);
    }
    {
      QImage image(paths[3]);
      image = image.scaledToWidth(imageWidth / 2, Qt::SmoothTransformation);
      painter.drawImage(imageWidth / 2, imageHeight / 2, image);
    }

    const QDateTime now = QDateTime::currentDateTime();
    const QString timestamp = now.toString("yyyyMMdd-hhmmsszzz");
    const QString filename =
        QString("%1/%2_composed.jpeg").arg(SESSION_PATH).arg(timestamp);
    gallery.save(filename);
  });
  m_watcher->setFuture(result);
}

void GalleryBuilder::futureFinished() { qDebug() << "Future finished"; }
