#include "photocapture.h"

#include "settings.h"

#include <QDebug>
#include <QProcess>

Photo PhotoCapture::capture() {
  const QDateTime now = QDateTime::currentDateTime();
  const QString timestamp = now.toString("yyyyMMdd-hhmmsszzz");
  const QString filename = QString("%2.jpeg").arg(timestamp);

  QProcess process;
  process.setWorkingDirectory(Settings::instance().tempPath());
  process.setProgram("/usr/local/bin/gphoto2");

  process.setArguments(
      {"--capture-image-and-download", "--filename", filename});

  process.start();
  process.waitForFinished(-1);

  Photo photo;
  photo.setPath(Settings::instance().tempPath() + "/" + filename);

  return photo;
}
