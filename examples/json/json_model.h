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

    QHash<int, QByteArray> roleNames() const override;
    void loadJson(const QString& path);

    Q_INVOKABLE int role(const QString& roleName) const;

private:
    void loadValue(const QJsonValue& value, TreeItem* parent);

    static const QHash<int, QByteArray> _roles;
};

#endif // JSONMODEL_H
