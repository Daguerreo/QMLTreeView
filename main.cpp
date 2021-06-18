#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "tree_model.h"

int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
   QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
   QGuiApplication app(argc, argv);

   auto treeModel = new TreeModel();
   auto root = treeModel->rootItem().get();
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

   treeModel->addTreeItem(root, parent1);
   treeModel->addTreeItem(root, parent2);
   treeModel->addTreeItem(root, parent3);
   treeModel->addTreeItem(root, parent4);
   treeModel->addTreeItem(root, parent5);
   treeModel->addTreeItem(root, parent6);

   treeModel->addTreeItem(parent1, child1);
   treeModel->addTreeItem(parent1, child2);
   treeModel->addTreeItem(parent1, child3);
   treeModel->addTreeItem(child1, grandChild1);
   treeModel->addTreeItem(child1, grandChild2);
   treeModel->addTreeItem(grandChild1, grateChild1);
   treeModel->addTreeItem(grandChild1, grateChild2);

   QQmlApplicationEngine engine;
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
