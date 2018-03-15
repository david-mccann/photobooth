#ifndef GALLERYBUILDER_H
#define GALLERYBUILDER_H

#include <QFutureWatcher>
#include <QList>
#include <QObject>
#include <QString>

class GalleryBuilder : public QObject {
  Q_OBJECT

public:
  GalleryBuilder();

  Q_INVOKABLE void makeGallery(const QList<QString> &paths);

signals:
  void finished(const QString &path);

private slots:
  void futureFinished();

private:
  QFutureWatcher<void> *m_watcher;
  QString mOutPath;
};

#endif // GALLERYBUILDER_H
