#include <QDir>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSurfaceFormat>

#include "gallerybuilder.h"
#include "maskedmousearea.h"
#include "photocapture.h"
#include "settings.h"

int main(int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;

  QSurfaceFormat surfaceFormat = QSurfaceFormat::defaultFormat();
  surfaceFormat.setRedBufferSize(8);
  surfaceFormat.setGreenBufferSize(8);
  surfaceFormat.setBlueBufferSize(8);
  QSurfaceFormat::setDefaultFormat(surfaceFormat);

  qRegisterMetaType<Photo>();

  qmlRegisterType<MaskedMouseArea>("InputHandling", 1, 0, "MaskedMouseArea");

  engine.load(QUrl(QLatin1String("qrc:/main.qml")));
  if (engine.rootObjects().isEmpty())
    return -1;

  QDir usbDriveDir(Settings::instance().usbDrivePath());
  if (!usbDriveDir.mkpath(".")) {
    qWarning() << "Cannot create directory: "
               << Settings::instance().usbDrivePath();
  }

  QDir tempDir(Settings::instance().tempPath());
  if (!tempDir.mkpath(".")) {
    qCritical() << "Cannot create directory: "
                << Settings::instance().tempPath();
    exit(1);
  }

  QDir sessionDir(Settings::instance().sessionPath());
  if (!sessionDir.mkpath(".")) {
    qCritical() << "Cannot create directory: "
                << Settings::instance().sessionPath();
    exit(1);
  }

  PhotoCapture capture;
  GalleryBuilder galleryBuilder;
  engine.rootContext()->setContextProperty("photoCapture", &capture);
  engine.rootContext()->setContextProperty("galleryBuilder", &galleryBuilder);
  engine.rootContext()->setContextProperty(
      "globalSettings", const_cast<Settings *>(&Settings::instance()));

  return app.exec();
}
