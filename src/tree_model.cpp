#include "tree_model.h"

TreeModel::TreeModel(QObject *parent)
   : QAbstractItemModel(parent),
     _rootItem{std::make_shared<TreeItem>(QVariantList{})}
{
}

int TreeModel::rowCount(const QModelIndex& parent) const
{
   if (!parent.isValid()){
      return _rootItem->childCount();
   }

   return internalPointer(parent)->childCount();
}

int TreeModel::columnCount(const QModelIndex&  /*parent*/) const
{
   // This is basically flatten as a list model
   return 1;
}

QModelIndex TreeModel::index(const int row, const int column, const QModelIndex& parent) const
{
   if (!hasIndex(row, column, parent)){
      return QModelIndex();
   }

   TreeItem* item = _rootItem.get();
   if (parent.isValid()){
      item = internalPointer(parent);
   }

   if (auto child = item->child(row)){
      return createIndex(row, column, child);
   }

   return QModelIndex();
}

QModelIndex TreeModel::parent(const QModelIndex& index) const
{
   if (!index.isValid()) return QModelIndex();

   TreeItem* childItem = internalPointer(index);
   TreeItem* parentItem = childItem->parentItem();

   if (parentItem == _rootItem.get()){
      return QModelIndex();
   }

   return createIndex(parentItem->row(), 0, parentItem);
}

QVariant TreeModel::data(const QModelIndex& index, const int role) const
{
   if (!index.isValid() || role != Qt::DisplayRole) {
      return QVariant();
   }

   return internalPointer(index)->data();
}

void TreeModel::addItem(TreeItem* parent, TreeItem* child)
{
   if(!child){
      return;
   }

   emit layoutAboutToBeChanged();

   if (child->parentItem()) {
      beginRemoveRows(QModelIndex(), child->parentItem()->childCount() - 1, child->parentItem()->childCount());
      child->parentItem()->removeChild(child);
      endRemoveRows();
   }

   beginInsertRows(QModelIndex(), parent->childCount() - 1, parent->childCount() - 1);
   child->setParentItem(parent);
   parent->appendChild(child);
   endInsertRows();

   emit layoutChanged();
}

std::shared_ptr<TreeItem> TreeModel::rootItem() const
{
   return _rootItem;
}

QModelIndex TreeModel::rootIndex()
{
   return QModelIndex();
}

TreeItem* TreeModel::internalPointer(const QModelIndex& index) const
{
   return static_cast<TreeItem* >(index.internalPointer());
}
