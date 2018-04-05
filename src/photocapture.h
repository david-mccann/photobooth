#ifndef PHOTOCAPTURE_H
#define PHOTOCAPTURE_H

#include <QDateTime>
#include <QFile>
#include <QObject>
#include <QProcess>

class PhotoCapture : public QObject {
  Q_OBJECT

  QProcess mProcess;
  QString mFilename;
  bool mFinished = false;

  signals:
  void finished(const QString& path);

  private slots:
  void processFinished(int);

  public:
  PhotoCapture(QObject* parent = Q_NULLPTR);

  Q_INVOKABLE void capture();
  Q_INVOKABLE void captureExtra();
};

#endif // PHOTOCAPTURE_H
