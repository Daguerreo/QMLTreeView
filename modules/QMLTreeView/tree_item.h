/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2021 Maurizio Ingrassia
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#ifndef QML_TREEVIEW_TREE_ITEM_H
#define QML_TREEVIEW_TREE_ITEM_H

#include <QVariant>

/*!
 * This class represents a node of the TreeModel.
 * TreeItem can be used to set and retreive information about the node,
 * insertion and removal is meant to be deal by the model.
 */
class TreeItem
{
   friend class TreeModel;

public:
   //! Instance a tree item with empty data.
   TreeItem();

   //! Instance a tree with the input data.
   explicit TreeItem(const QVariant& data);

   //! Destroy the item and all its children.
   ~TreeItem();

   //! Return the internal data.
   const QVariant& data() const;

   //! Set the internal data.
   void setData(const QVariant& data);

   //! Return the number of children of the item.
   int childCount() const;

   //! Return the number of the row referred to the parent item.
   int row() const;

   //! Return true if the item has no children.
   bool isLeaf() const;

   //! Return the depth of the item in the hierarchy.
   int depth() const;

private:
   TreeItem* parentItem();
   void setParentItem(TreeItem* parentItem);

   void appendChild(TreeItem* item);
   void removeChild(TreeItem* item);

   TreeItem* child(int row);

private:
   QVariant _itemData;
   TreeItem* _parentItem;
   QVector<TreeItem*> _childItems;
};

#endif // QML_TREEVIEW_TREE_ITEM_H
