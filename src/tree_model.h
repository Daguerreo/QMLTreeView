#pragma once

#include <memory>

#include <QAbstractItemModel>

#include "tree_item.h"

class TreeModel : public QAbstractItemModel
{
   Q_OBJECT

public:
   explicit TreeModel(QObject *parent = nullptr);

   int rowCount(const QModelIndex& index) const override;
   int columnCount(const QModelIndex& index) const override;

   QModelIndex index(const int row, const int column, const QModelIndex &parent) const override;
   QModelIndex parent(const QModelIndex& childIndex) const override;

   QVariant data(const QModelIndex& index, const int role = 0) const override;

   void addTreeItem(TreeItem* parent, TreeItem* child);

   std::shared_ptr<TreeItem> rootItem() const;

   Q_INVOKABLE QModelIndex rootIndex();

private:
   TreeItem* internalPointer(const QModelIndex& index) const;

private:
   std::shared_ptr<TreeItem> _rootItem;
};
