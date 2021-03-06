#include "settings.h"

#include <QDebug>

std::unique_ptr<Settings> Settings::pInstance = nullptr;

Settings::Settings()
    : QObject(nullptr)
    , m_settings("settings.ini", QSettings::IniFormat) {}

Settings::~Settings() = default;

const Settings& Settings::instance() {
  if (Settings::pInstance == nullptr) {
    Settings::pInstance = std::unique_ptr<Settings>(new Settings);
  }
  return *pInstance;
}

QString Settings::localPath() const {
  return m_settings.value("Settings/LocalPath").toString();
}

QString Settings::tempPath() const {
  return QString("%1/temp").arg(m_settings.value("Settings/LocalPath").toString());
}

QString Settings::sessionPath() const {
  return QString("%1/session").arg(m_settings.value("Settings/LocalPath").toString());
}

QString Settings::usbDrivePath() const {
  return m_settings.value("Settings/USBDrivePath").toString();
}

QSize Settings::scaledImageSize() const {
  return m_settings.value("Settings/ScaledImageSize").toSize();
}

int Settings::countdownDuration() const {
  return m_settings.value("Settings/CountdownDuration").toInt();
}

int Settings::slideshowDuration() const {
  return m_settings.value("Settings/SlideshowDuration").toInt();
}

int Settings::galleryDuration() const {
  return m_settings.value("Settings/GalleryDuration").toInt();
}
