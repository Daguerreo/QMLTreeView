#pragma once

#include <QVariant>

/*!
 * This class represents a node of the TreeModel
 */
class TreeItem
{
public:
   explicit TreeItem(const QVariant& data, TreeItem* parent = nullptr);
   TreeItem(TreeItem* parent, const QVector<TreeItem*>& children);
   ~TreeItem();

   TreeItem* parentItem();
   void setParentItem(TreeItem *parentItem);

   void appendChild(TreeItem* item);
   void removeChild(TreeItem* item);

   TreeItem* child(int row);
   int childCount() const;
   int row() const;

   const QVariant& data() const;
   void setData(const QVariant& data);

private:
   TreeItem* _parentItem;
   QVector<TreeItem*> _childItems;
   QVariant _itemData;
};
