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

public:
  ~Settings();

  static const Settings &instance();

  QString tempPath() const;
  QString sessionPath() const;

  QSize scaledImageSize() const;

  int countdownDuration() const;
  int slideshowDuration() const;

private:
  Settings();

private:
  static std::unique_ptr<Settings> pInstance;
  QSettings m_settings;
};

#endif // SETTINGS_H
