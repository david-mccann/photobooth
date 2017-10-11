#include "photocapture.h"

#include "settings.h"

#include <QDebug>

Photo PhotoCapture::capture() {
  const QDateTime now = QDateTime::currentDateTime();
  const QString timestamp = now.toString("yyyyMMdd-hhmmsszzz");
  const QString filename =
      QString("%1/%2.jpeg").arg(Settings::instance().tempPath()).arg(timestamp);

  // workaround
  static int count = 0;
  int index = (count++) % 4 + 1;
  QString path = QString("%1/%2.jpeg")
                     .arg(Settings::instance().tempPath())
                     .arg(QString::number(index));
  qDebug() << path;
  QFile::copy(path, filename);

  Photo photo;
  photo.setPath(filename);
  return photo;
}
