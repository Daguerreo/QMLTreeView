#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

#include "tree_model.h"
#include "json_entry.h"


void loadValue(const QJsonValue& value, TreeItem* parent, TreeModel* model)
{

   if(value.isObject()) {
      auto object = value.toObject();
      for(auto it=object.begin(); it!=object.end(); ++it){
         JsonEntry entry;
         entry.setKey(it.key());
         entry.setType(QJsonValue::Object);
         if(it.value().isArray() || it.value().isObject()){
            auto child = new TreeItem(QVariant::fromValue(entry));
            loadValue(it.value(), child, model);
            model->addItem(parent, child);
         }
         else {
            entry.setValue(it.value().toVariant());
            auto child = new TreeItem(QVariant::fromValue(entry));
            model->addItem(parent, child);
         }
      }
   }
   else if(value.isArray()){
      int index = 0;
      auto array = value.toArray();
      for(auto&& element: array){
         JsonEntry entry;
         entry.setKey("[" + QString::number(index) + "]");
         entry.setType(QJsonValue::Array);
         auto child = new TreeItem(QVariant::fromValue(entry));
         model->addItem(parent, child);
         loadValue(element, child, model);
         ++index;
      }
   }
   else {
      JsonEntry entry;
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

   auto root = doc.isArray() ? QJsonValue(doc.array()) : QJsonValue(doc.object());
   loadValue(root, jsonModel->rootItem().get(), jsonModel);

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

