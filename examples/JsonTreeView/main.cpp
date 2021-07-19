#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

#include "tree_model.h"
#include "json_entry.h"

void load(const QString& key, const QJsonValue& value, TreeModel* model, TreeItem* parent)
{
   if(value.isObject()) {
      JsonEntry entry;
      entry.setKey(key);
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

   auto jsonModel = populateJson();

   QQmlApplicationEngine engine;
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

