#ifndef SETTINGS_H
#define SETTINGS_H

#include <memory>

#include <QObject>
#include <QSettings>
#include <QSize>
#include <QString>

class Settings : public QObject {
  Q_OBJECT
  Q_PROPERTY(int countdownDuration READ countdownDuration)
  Q_PROPERTY(int slideshowDuration READ slideshowDuration)
  Q_PROPERTY(int galleryDuration READ galleryDuration)

  public:
  ~Settings();

  static const Settings& instance();

  QString localPath() const;
  QString tempPath() const;
  QString sessionPath() const;
  QString usbDrivePath() const;

  QSize scaledImageSize() const;

  int countdownDuration() const;
  int slideshowDuration() const;
  int galleryDuration() const;

  private:
  Settings();

  private:
  static std::unique_ptr<Settings> pInstance;
  QSettings m_settings;
};

#endif // SETTINGS_H
