#ifndef PHOTO_H
#define PHOTO_H

#include <QObject>
#include <QString>

class Photo {
  Q_GADGET
  Q_PROPERTY(QString path READ path WRITE setPath)

public:
  QString path() const;
  void setPath(const QString &path);

  Q_INVOKABLE void saveInSession();
  Q_INVOKABLE void saveAsExtraPhoto();
  Q_INVOKABLE void remove();

private:
  QString m_path;
};

Q_DECLARE_METATYPE(Photo)

#endif // PHOTO_H
