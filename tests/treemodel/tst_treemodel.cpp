#include <QtTest>
#include "tree_model.h"

class TestTreeModel : public QObject
{
    Q_OBJECT

private:
    enum TestRole {
        FooRole = Qt::UserRole + 1,
        BarRole,
        BazRole
    };

    auto createModel() {
        return std::make_unique<TreeModel>();
    }

    auto createItem() {
        return new TreeItem();
    }

    auto createItem(QVariant data) {
        return new TreeItem(std::move(data));
    }

private slots:
    void addItems();
    void addCustomData();
    void setDataMultipleTimes();
    void removeItem();
};


void TestTreeModel::addItems()
{
    auto model = createModel();

    const auto parent = createItem("parent");
    model->addTopLevelItem(parent);

    const auto parentIndex = model->index(0, 0, QModelIndex());
    QCOMPARE(model->data(parentIndex), "parent");
    QCOMPARE(model->rowCount(parentIndex), 0);

    const auto child = createItem("child");
    model->addItem(parent, child);

    const auto childIndex = model->index(0, 0, parentIndex);
    QCOMPARE(model->data(childIndex), "child");
    QCOMPARE(model->rowCount(parentIndex), 1);
    QCOMPARE(model->rowCount(childIndex), 0);

    const auto brother = createItem("brother");
    model->addItem(parent, brother);

    const auto brotherIndex = model->index(1, 0, parentIndex);
    QCOMPARE(model->data(brotherIndex), "brother");
    QCOMPARE(model->rowCount(parentIndex), 2);
    QCOMPARE(model->rowCount(childIndex), 0);
    QCOMPARE(model->rowCount(brotherIndex), 0);

}

void TestTreeModel::addCustomData()
{
    auto model = createModel();

    const auto parent = createItem();
    parent->setData("parent");
    parent->setData("yellow", Qt::DecorationRole);
    parent->setData("this is a node", Qt::ToolTipRole);

    model->addTopLevelItem(parent);

    const auto parentIndex = model->index(0, 0, QModelIndex());
    QCOMPARE(model->data(parentIndex), "parent");
    QCOMPARE(model->data(parentIndex, Qt::DecorationRole), "yellow");
    QCOMPARE(model->data(parentIndex, Qt::ToolTipRole), "this is a node");
}

void TestTreeModel::setDataMultipleTimes()
{
    auto model = createModel();
    const auto parent = createItem();
    model->addTopLevelItem(parent);
    const auto parentIndex = model->index(0, 0, QModelIndex());

    model->setData(parentIndex, "foo", FooRole);
    QCOMPARE(model->data(parentIndex, FooRole), "foo");

    model->setData(parentIndex, "foo2", FooRole);
    QCOMPARE(model->data(parentIndex, FooRole), "foo2");
}

void TestTreeModel::removeItem()
{
    auto model = createModel();

    const auto parent = createItem("parent");
    const auto child = createItem("child");
    const auto brother = createItem("brother");
    const auto grandson = createItem("grandson");

    model->addTopLevelItem(parent);
    model->addItem(parent, child);
    model->addItem(parent, brother);
    model->addItem(child, grandson);

    const auto parentIndex = model->index(0, 0, QModelIndex());
    const auto childIndex = model->index(0, 0, parentIndex);

    QCOMPARE(model->rowCount(parentIndex), 2);
    QCOMPARE(model->rowCount(childIndex), 1);

    model->removeItem(child);
    QCOMPARE(model->rowCount(parentIndex), 1);
}

QTEST_APPLESS_MAIN(TestTreeModel)

#include "tst_treemodel.moc"
