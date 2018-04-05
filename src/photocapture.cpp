#include "photocapture.h"

#include "settings.h"

#include <QDebug>
#include <QFile>
#include <QProcess>
#include <QThread>

#define MOCK_CAPTURE

PhotoCapture::PhotoCapture(QObject* /*parent*/) {
  mProcess.setWorkingDirectory(Settings::instance().tempPath());
#ifdef MOCK_CAPTURE
  mProcess.setProgram("sleep");
#else
  mProcess.setProgram("/usr/local/bin/gphoto2");
#endif
  connect(&mProcess, SIGNAL(finished(int)), this, SLOT(processFinished(int)));
}

void PhotoCapture::capture() {
  const QDateTime now = QDateTime::currentDateTime();
  const QString timestamp = now.toString("yyyyMMdd-hhmmsszzz");
  mFilename = QString("%2.jpeg").arg(timestamp);
#ifdef MOCK_CAPTURE
  mProcess.setArguments({"1"});
#else
  mProcess.setArguments({"--capture-image-and-download", "--filename", mFilename});
#endif
  mProcess.start();
}

void PhotoCapture::captureExtra() {
  mFilename = "extra.jpeg";
  QFile::remove(mFilename);
#ifdef MOCK_CAPTURE
  mProcess.setArguments({"1"});
#else
  mProcess.setArguments({"--capture-image-and-download", "--filename", mFilename});
#endif
  mProcess.start();
}

void PhotoCapture::processFinished(int) {
  QString newPath = QString("%1/%2").arg(Settings::instance().sessionPath()).arg(mFilename);

  QFile::remove(newPath);

#ifdef MOCK_CAPTURE
  static int count = 0;
  ++count;
  QString mockFile = Settings::instance().tempPath() + "/mock" + QString::number((count % 4) + 1) + ".jpeg";
  QFile::copy(mockFile, newPath);
#else
  QFile::rename(mFilename, newPath);
#endif

  QString usbPath = QString("%1/%2").arg(Settings::instance().usbDrivePath()).arg(mFilename);
  QFile::copy(newPath, usbPath);

  emit finished(newPath);
}
