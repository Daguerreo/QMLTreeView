#include "tree_item.h"
#include "tree_manipulator.h"
#include "tree_model.h"

TreeManipulator::TreeManipulator(TreeModel& model, QObject* parent)
    : QObject(parent)
    , _model(&model)
{}

QVariant TreeManipulator::sourceModel() const
{
    return QVariant::fromValue(_model);
}

void TreeManipulator::addTopLevelItem(const QString& data)
{
    _model->addTopLevelItem(new TreeItem(data));
}

void TreeManipulator::addItem(const QModelIndex& index, const QString& data)
{
    if (!index.isValid()) {
        return;
    }

    auto parent = static_cast<TreeItem*>(index.internalPointer());
    _model->addItem(parent, new TreeItem(data));
}

void TreeManipulator::removeItem(const QModelIndex& index)
{
    if (!index.isValid()) {
        return;
    }

    auto item = static_cast<TreeItem*>(index.internalPointer());
    _model->removeItem(item);
}

void TreeManipulator::editItem(const QModelIndex& index, const QString& data)
{
    if (!index.isValid()) {
        return;
    }

    _model->setData(index, data);
}

void TreeManipulator::reset()
{
    _model->clear();
}
