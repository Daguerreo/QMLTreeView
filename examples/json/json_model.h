#ifndef JSONMODEL_H
#define JSONMODEL_H

#include "tree_model.h"

class JsonModel : public TreeModel
{
    Q_OBJECT

public:
    enum Roles {
        ValueRole = Qt::UserRole + 1,
        KeyRole
    };

    explicit JsonModel(QObject* parent = nullptr);

    QHash<int, QByteArray> roleNames() const;
    void loadJson(const QString& path);

private:
    void loadValue(const QJsonValue& value, TreeItem* parent);
};

#endif // JSONMODEL_H
