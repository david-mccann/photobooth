#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "gallerybuilder.h"
#include "photocapture.h"
#include "settings.h"

int main(int argc, char *argv[]) {
  QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;

  qRegisterMetaType<Photo>();

  engine.load(QUrl(QLatin1String("qrc:/main.qml")));
  if (engine.rootObjects().isEmpty())
    return -1;

  PhotoCapture capture;
  GalleryBuilder galleryBuilder;
  engine.rootContext()->setContextProperty("photoCapture", &capture);
  engine.rootContext()->setContextProperty("galleryBuilder", &galleryBuilder);
  engine.rootContext()->setContextProperty(
      "globalSettings", const_cast<Settings *>(&Settings::instance()));

  return app.exec();
}
