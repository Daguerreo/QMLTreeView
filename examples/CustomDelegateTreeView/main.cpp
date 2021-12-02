#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "tree_model.h"

void populateModel(TreeModel& model)
{
   auto parent1 = new TreeItem("Parent1");
   auto parent2 = new TreeItem("Parent2");
   auto parent3 = new TreeItem("Parent3");
   auto parent4 = new TreeItem("Parent4");
   auto parent5 = new TreeItem("Parent5");
   auto parent6 = new TreeItem("Parent6");

   auto child1 = new TreeItem("Child1");
   auto child2 = new TreeItem("Child2");
   auto child3 = new TreeItem("Child3");
   auto grandChild1 = new TreeItem("GrandChild1");
   auto grandChild2 = new TreeItem("GrandChild2");
   auto grateChild1 = new TreeItem("GreateChild1");
   auto grateChild2 = new TreeItem("GreateChild2");

   model.addTopLevelItem(parent1);
   model.addTopLevelItem(parent2);
   model.addTopLevelItem(parent3);
   model.addTopLevelItem(parent4);
   model.addTopLevelItem(parent5);
   model.addTopLevelItem(parent6);

   model.addItem(parent1, child1);
   model.addItem(parent1, child2);
   model.addItem(parent1, child3);
   model.addItem(child1, grandChild1);
   model.addItem(child1, grandChild2);
   model.addItem(grandChild1, grateChild1);
   model.addItem(grandChild1, grateChild2);
}

int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
   QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
   QGuiApplication app(argc, argv);
   QQmlApplicationEngine engine;

   auto treeModel = new TreeModel(&engine);
   populateModel(*treeModel);

   engine.rootContext()->setContextProperty("treeModel", treeModel);
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

