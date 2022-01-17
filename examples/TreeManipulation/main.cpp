#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "tree_model.h"
#include "tree_manipulator.h"


int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
   QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
   QGuiApplication app(argc, argv);
   QQmlApplicationEngine engine;

   auto treeModel = new TreeModel(&engine);
   auto treeManipulator = new TreeManipulator(*treeModel, &engine);

   engine.rootContext()->setContextProperty("treeManipulator", QVariant::fromValue(treeManipulator));

   const QUrl url(QStringLiteral("qrc:/main.qml"));
   QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreated, &app,
      [url](QObject *obj, const QUrl &objUrl) {
         if (!obj && url == objUrl) QCoreApplication::exit(-1);
      },
      Qt::QueuedConnection);
   engine.load(url);

   return app.exec();
}
