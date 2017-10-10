#ifndef PHOTOCAPTURE_H
#define PHOTOCAPTURE_H

#include <QDateTime>
#include <QFile>
#include <QObject>

#include "photo.h"

class PhotoCapture : public QObject {
  Q_OBJECT

public:
  Q_INVOKABLE Photo capture();
};

#endif // PHOTOCAPTURE_H
