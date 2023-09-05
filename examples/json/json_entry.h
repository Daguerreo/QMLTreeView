#ifndef JSONENTRY_H
#define JSONENTRY_H

#include <QJsonValue>

class JsonEntry
{
    Q_GADGET
    Q_PROPERTY(QString key READ key WRITE setKey)
    Q_PROPERTY(QVariant value READ value WRITE setValue)
    Q_PROPERTY(QJsonValue::Type type READ type WRITE setType)

public:
    JsonEntry();
    JsonEntry(const QString& key, const QVariant& value, QJsonValue::Type type);

    QString key() const;
    void setKey(QString key);

    QVariant value() const;
    void setValue(QVariant value);

    QJsonValue::Type type() const;
    void setType(QJsonValue::Type type);

    Q_INVOKABLE bool isObject() const;
    Q_INVOKABLE bool isArray() const;
    Q_INVOKABLE bool isValue() const;

private:
    QString _key;
    QVariant _value;
    QJsonValue::Type _type;
};

Q_DECLARE_METATYPE(JsonEntry)

#endif // JSONENTRY_H
