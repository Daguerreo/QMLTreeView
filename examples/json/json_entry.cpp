#include "json_entry.h"

JsonEntry::JsonEntry()
    : _type(QJsonValue::Null)
{}

JsonEntry::JsonEntry(const QString& key, const QVariant& value, QJsonValue::Type type)
    : _key(key)
    , _value(value)
    , _type(type)
{}

QString JsonEntry::key() const
{
    return _key;
}

QVariant JsonEntry::value() const
{
    return _value;
}

QJsonValue::Type JsonEntry::type() const
{
    return _type;
}

void JsonEntry::setKey(QString key)
{
    if (_key == key)
        return;

    _key = key;
}

void JsonEntry::setValue(QVariant value)
{
    if (_value == value)
        return;

    _value = value;
}

void JsonEntry::setType(QJsonValue::Type type)
{
    if (_type == type)
        return;

    _type = type;
}

bool JsonEntry::isObject() const
{
    return _type == QJsonValue::Object;
}

bool JsonEntry::isArray() const
{
    return _type == QJsonValue::Array;
}

bool JsonEntry::isValue() const
{
    return !(isObject() || isArray());
}
