#include "photo.h"

#include "settings.h"

#include <QFile>
#include <QFileInfo>

QString Photo::path() const { return m_path; }

void Photo::setPath(const QString &path) { m_path = path; }

void Photo::saveInSession() {
  QFileInfo info(m_path);
  QString filename = info.fileName();

  QString newPath =
      QString("%1/%2").arg(Settings::instance().sessionPath()).arg(filename);
  QFile::rename(m_path, newPath);

  QString usbPath =
      QString("%1/%2").arg(Settings::instance().usbDrivePath()).arg(filename);
  QFile::copy(newPath, usbPath);
  m_path = newPath;
}

void Photo::saveAsExtraPhoto() {
  QString newPath = QString("%1/%2")
                        .arg(Settings::instance().sessionPath())
                        .arg("extra.jpeg");
  if (QFile::exists(newPath)) {
    QFile::remove(newPath);
  }

  QFile::rename(m_path, newPath);

  QString usbPath = QString("%1/%2")
                        .arg(Settings::instance().usbDrivePath())
                        .arg("extra.jpeg");
  if (QFile::exists(usbPath)) {
    QFile::remove(usbPath);
  }

  QFile::copy(newPath, usbPath);
  m_path = newPath;
}

void Photo::remove() { QFile::remove(m_path); }
