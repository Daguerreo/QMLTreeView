#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

#include "tree_model.h"
#include "json_entry.h"

TreeModel* populateModel()
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

   auto treeModel = new TreeModel();
   treeModel->addTopLevelItem(parent1);
   treeModel->addTopLevelItem(parent2);
   treeModel->addTopLevelItem(parent3);
   treeModel->addTopLevelItem(parent4);
   treeModel->addTopLevelItem(parent5);
   treeModel->addTopLevelItem(parent6);

   treeModel->addItem(parent1, child1);
   treeModel->addItem(parent1, child2);
   treeModel->addItem(parent1, child3);
   treeModel->addItem(child1, grandChild1);
   treeModel->addItem(child1, grandChild2);
   treeModel->addItem(grandChild1, grateChild1);
   treeModel->addItem(grandChild1, grateChild2);

   return treeModel;
}

void load(const QString& key, const QJsonValue& value, TreeModel* model, TreeItem* parent)
{
   if(value.isObject()) {
      JsonEntry entry;
      entry.setKey(key);
      entry.setValue("object");
      entry.setType(QJsonValue::Object);
      auto child = new TreeItem(QVariant::fromValue(entry));

      auto obj = value.toObject();
      for(auto it=obj.begin(); it!=obj.end(); ++it) {
         model->addItem(parent, child);
         load(it.key(), it.value(), model, child);
      }
   }
   else if(value.isArray()) {
      JsonEntry entry;
      entry.setKey(key);
      entry.setValue("array");
      entry.setType(QJsonValue::Array);
      auto child = new TreeItem(QVariant::fromValue(entry));

      auto array = value.toArray();
      int index = 0;
      for(auto&& element : array){
         model->addItem(parent, child);
         load(QString::number(index), element, model, child);
         ++index;
      }
   }
   else {
      JsonEntry entry;
      entry.setKey(key);
      entry.setValue(value.toVariant());
      entry.setType(value.type());
      auto child = new TreeItem(QVariant::fromValue(entry));
      model->addItem(parent, child);
   }
}

TreeModel* populateJson()
{
   QString json = R"(
   {
      "firstName": "John",
      "lastName": "Smith",
      "age": 25,
      "address": {
         "streetAddress": "21 2nd Street",
         "city": "New York",
         "state": "NY",
         "postalCode": "10021",
         "owner": true
      },
      "phoneNumber": [
         {
           "type": "home",
           "number": "212 555-1234"
         },
         {
           "type": "fax",
           "number": "646 555-4567"
         }
      ]
   })";

   QJsonParseError error;
   auto doc = QJsonDocument::fromJson(json.toUtf8(), &error);
   qDebug() << error.errorString();

   auto jsonModel = new TreeModel();

   auto obj = doc.isArray() ? QJsonValue(doc.array()) : QJsonValue(doc.object());
   load("root", obj, jsonModel, jsonModel->rootItem().get());

   return jsonModel;
}

int main(int argc, char *argv[]) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
   QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
   QGuiApplication app(argc, argv);

   auto treeModel = populateModel();
   auto jsonModel = populateJson();

   QQmlApplicationEngine engine;
   engine.rootContext()->setContextProperty("treeModel", treeModel);
   engine.rootContext()->setContextProperty("jsonModel", jsonModel);
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

