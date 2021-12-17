#include "tree_manipulator.h"
#include "tree_model.h"
#include "tree_item.h"

TreeManipulator::TreeManipulator(TreeModel& model, QObject* parent)
   : QObject(parent),
     _model(&model)
{
}

void TreeManipulator::addTopLevelItem(const QString& data)
{
   _model->addTopLevelItem(new TreeItem(data));
}

void TreeManipulator::addItem(const QModelIndex& index, const QString& data)
{
   if(!index.isValid()){
      return;
   }

   auto parent = static_cast<TreeItem*>(index.internalPointer());
   _model->addItem(parent, new TreeItem(data));
}

void TreeManipulator::removeItem(const QModelIndex& index)
{

}

void TreeManipulator::reset()
{
   _model->clear();
}
