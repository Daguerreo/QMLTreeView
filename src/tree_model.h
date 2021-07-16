#pragma once

#include <memory>

#include <QAbstractItemModel>

#include "tree_item.h"

class TreeModel : public QAbstractItemModel
{
   Q_OBJECT

public:
   explicit TreeModel(QObject* parent = nullptr);

public:
   int rowCount(const QModelIndex& index) const override;
   int columnCount(const QModelIndex& index) const override;

   QModelIndex index(int row, int column, const QModelIndex& parent) const override;
   QModelIndex parent(const QModelIndex& childIndex) const override;

   QVariant data(const QModelIndex& index, int role = 0) const override;

public:
   void addTopLevelItem(TreeItem* child);
   void addItem(TreeItem* parent, TreeItem* child);

   std::shared_ptr<TreeItem> rootItem() const;

   Q_INVOKABLE QModelIndex rootIndex();
   Q_INVOKABLE int depth(const QModelIndex& index) const;
   Q_INVOKABLE void clear();

private:
   TreeItem* internalPointer(const QModelIndex& index) const;

private:
   std::shared_ptr<TreeItem> _rootItem;
};
