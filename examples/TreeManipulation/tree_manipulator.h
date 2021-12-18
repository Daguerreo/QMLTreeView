#ifndef TREE_MANIPULATOR_H
#define TREE_MANIPULATOR_H

#include <QObject>
#include <QVariant>

class TreeModel;

/*!
 * Expose manipulation feature of the Tree Model to QML
 */
class TreeManipulator : public QObject
{
   Q_OBJECT

public:
   explicit TreeManipulator(TreeModel& model, QObject* parent = nullptr);

   Q_INVOKABLE QVariant sourceModel() const;
   Q_INVOKABLE void addTopLevelItem(const QString& data);
   Q_INVOKABLE void addItem(const QModelIndex& index, const QString& data);
   Q_INVOKABLE void removeItem(const QModelIndex& index);
   Q_INVOKABLE void editItem(const QModelIndex& index, const QString& data);
   Q_INVOKABLE void reset();

private:
   TreeModel* _model;
};

#endif // TREE_MANIPULATOR_H
