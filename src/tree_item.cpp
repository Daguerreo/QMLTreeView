#include "tree_item.h"

TreeItem::TreeItem(const QVariant& data, TreeItem* parent)
   : _parentItem(parent),
     _itemData(data)
{}

TreeItem::TreeItem(TreeItem* parent, const QVector<TreeItem*>& children)
   : _parentItem(parent),
     _childItems(children)
{}

TreeItem::~TreeItem()
{
   qDeleteAll(_childItems);
}

TreeItem* TreeItem::parentItem()
{
   return _parentItem;
}

void TreeItem::setParentItem(TreeItem *parentItem)
{
   _parentItem = parentItem;
}

void TreeItem::appendChild(TreeItem *item)
{
   if(item && !_childItems.contains(item)){
      _childItems.append(item);
   }
}

void TreeItem::removeChild(TreeItem *item)
{
   if(item){
      _childItems.removeAll(item);
   }
}

TreeItem* TreeItem::child(int row)
{
   return _childItems.value(row);
}

int TreeItem::childCount() const
{
   return _childItems.count();
}

const QVariant& TreeItem::data() const
{
   return _itemData;
}

void TreeItem::setData(const QVariant& data)
{
   _itemData = data;
}

int TreeItem::row() const
{
   if (_parentItem){
      return _parentItem->_childItems.indexOf(const_cast<TreeItem *>(this));
   }

   return 0;
}
