#include "photocapture.h"

#include "settings.h"

#include <QDebug>
#include <QFile>
#include <QProcess>
#include <QThread>

#define MOCK_CAPTURE

Photo PhotoCapture::capture() {
  const QDateTime now = QDateTime::currentDateTime();
  const QString timestamp = now.toString("yyyyMMdd-hhmmsszzz");
  const QString filename = QString("%2.jpeg").arg(timestamp);
#ifdef MOCK_CAPTURE
  static int count = 0;
  ++count;
  QString mockFile = Settings::instance().tempPath() + "/mock" +
                     QString::number((count % 4) + 1) + ".jpeg";
  QString newFile = Settings::instance().tempPath() + "/" + filename;
  QFile::copy(mockFile, newFile);

  QThread::sleep(1);

  Photo photo;
  photo.setPath(newFile);

  return photo;
#else
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
#endif
}
