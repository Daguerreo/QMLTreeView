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

#ifndef QML_TREEVIEW_TREE_MODEL_H
#define QML_TREEVIEW_TREE_MODEL_H

#include <QAbstractItemModel>

#include "tree_item.h"

/*!
 * Generic Tree Model.
 */
class TreeModel : public QAbstractItemModel
{
   Q_OBJECT

public:
   explicit TreeModel(QObject* parent = nullptr);
   ~TreeModel() override;

public:
   int rowCount(const QModelIndex& index) const override;
   int columnCount(const QModelIndex& index) const override;

   QModelIndex index(int row, int column, const QModelIndex& parent) const override;
   QModelIndex parent(const QModelIndex& childIndex) const override;

   QVariant data(const QModelIndex& index, int role = 0) const override;
   bool setData(const QModelIndex& index, const QVariant& value, int role = Qt::EditRole) override;

public:
   //! Add an item to the top level.
   void addTopLevelItem(TreeItem* child);

   //! Add the item child to the parent node.
   void addItem(TreeItem* parent, TreeItem* child);

   //! Remove the item and all its children.
   void removeItem(TreeItem* item);

   //! Return the root item.
   TreeItem* rootItem() const;

   //! Return the root Model Index. Needed for the QML side.
   Q_INVOKABLE QModelIndex rootIndex();

   //! Return the depth of the item for the selected index.
   Q_INVOKABLE int depth(const QModelIndex& index) const;

   //! Remove all the elements from the tree.
   Q_INVOKABLE void clear();

private:
   TreeItem* internalPointer(const QModelIndex& index) const;

private:
   TreeItem* _rootItem;
};

#endif // QML_TREEVIEW_TREE_MODEL_H
