#include "json_entry.h"
#include "tree_model.h"

#include <QFile>
#include <QGuiApplication>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>

void loadValue(const QJsonValue& value, TreeItem* parent, TreeModel* model)
{
    if (value.isObject()) {
        auto object = value.toObject();
        for (auto it = object.begin(); it != object.end(); ++it) {
            JsonEntry entry;
            entry.setKey(it.key());
            entry.setType(QJsonValue::Object);
            if (it.value().isArray() || it.value().isObject()) {
                auto child = new TreeItem(QVariant::fromValue(entry));
                loadValue(it.value(), child, model);
                model->addItem(parent, child);
            } else {
                entry.setValue(it.value().toVariant());
                auto child = new TreeItem(QVariant::fromValue(entry));
                model->addItem(parent, child);
            }
        }
    } else if (value.isArray()) {
        int index = 0;
        auto array = value.toArray();
        for (auto&& element : array) {
            JsonEntry entry;
            entry.setKey("[" + QString::number(index) + "]");
            entry.setType(QJsonValue::Array);
            auto child = new TreeItem(QVariant::fromValue(entry));
            model->addItem(parent, child);
            loadValue(element, child, model);
            ++index;
        }
    } else {
        JsonEntry entry;
        entry.setValue(value.toVariant());
        entry.setType(value.type());
        auto child = new TreeItem(QVariant::fromValue(entry));
        model->addItem(parent, child);
    }
}

void populateModel(TreeModel& model)
{
    QFile jsonFile{":/sample.json"};
    if (!jsonFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qCritical() << "error: json file cannot be open";
        return;
    }

    QJsonParseError error;
    auto doc = QJsonDocument::fromJson(jsonFile.readAll(), &error);
    qDebug() << "loading json file:" << error.errorString();

    auto root = doc.isArray() ? QJsonValue(doc.array()) : QJsonValue(doc.object());
    loadValue(root, model.rootItem(), &model);
}

int main(int argc, char* argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/modules");

    auto jsonModel = new TreeModel(&engine);
    populateModel(*jsonModel);

    engine.rootContext()->setContextProperty("jsonModel", jsonModel);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
