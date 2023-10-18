#include "json_model.h"

#include <QDebug>
#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>

JsonModel::JsonModel(QObject* parent)
    : TreeModel(parent)
{
}

QHash<int, QByteArray> JsonModel::roleNames() const
{
    static const QHash<int, QByteArray> roles = {
        { ValueRole, "value" },
        { KeyRole, "key" }
    };

    return roles;
}

void JsonModel::loadJson(const QString &path)
{
    QFile jsonFile{path};
    if (!jsonFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qCritical() << "error: json file cannot be open";
        return;
    }

    QJsonParseError error;
    auto doc = QJsonDocument::fromJson(jsonFile.readAll(), &error);
    qDebug() << "loading json file:" << error.errorString();

    auto root = doc.isArray() ? QJsonValue(doc.array()) : QJsonValue(doc.object());
    loadValue(root, rootItem());
}

void JsonModel::loadValue(const QJsonValue &value, TreeItem* parent)
{
    if (value.isObject()) {
        auto object = value.toObject();
        for (auto it = object.begin(); it != object.end(); ++it) {
            const auto key = it.key();
            const auto value = it.value();

            auto child = new TreeItem();
            child->setData(key, JsonModel::KeyRole);

            if (value.isArray() || value.isObject()) {
                child->setData("", JsonModel::ValueRole);
                loadValue(value, child);
                addItem(parent, child);
            } else {
                child->setData(value.toVariant(), JsonModel::ValueRole);
                addItem(parent, child);
            }
        }
    } else if (value.isArray()) {
        int index = 0;
        auto array = value.toArray();
        for (auto&& element : array) {
            auto child = new TreeItem();
            child->setData("[" + QString::number(index) + "]", JsonModel::KeyRole);
            child->setData("", JsonModel::ValueRole);
            addItem(parent, child);
            loadValue(element, child);
            ++index;
        }
    } else {
        auto child = new TreeItem();
        child->setData(value.toVariant(), JsonModel::ValueRole);
        addItem(parent, child);
    }
}
