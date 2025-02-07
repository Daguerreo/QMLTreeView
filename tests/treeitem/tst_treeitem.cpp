#include <QtTest>
#include "tree_item.h"

class TestTreeItem : public QObject
{
    Q_OBJECT

    enum TestRole {
        FooRole = Qt::UserRole + 1,
        BarRole,
        BazRole
    };

private:
    auto createItem() {
        return std::make_unique<TreeItem>();
    }

    auto createItem(QVariant data) {
        return std::make_unique<TreeItem>(std::move(data));
    }

private slots:
    void defaultConstructor();

    void constructor_data();
    void constructor();

    void setData_data();
    void setData();

    void roles();
    void itemData();
};

void TestTreeItem::defaultConstructor()
{
    auto item = createItem();

    QCOMPARE(item->data(), QVariant{});
    QCOMPARE(item->childCount(), 0);
    QCOMPARE(item->row(), 0);
    QCOMPARE(item->depth(), 0);
    QCOMPARE(item->isLeaf(), true);
    QVERIFY(item->roles().isEmpty());
    QVERIFY(item->itemData().isEmpty());
}

void TestTreeItem::constructor_data()
{
    QTest::addColumn<QVariant>("data");

    auto v = [](auto&& v){ return QVariant(v); };

    QTest::newRow("1") << v("hello world");
    QTest::newRow("2") << v(2);
    QTest::newRow("3") << v(true);
    QTest::newRow("4") << v(QDateTime::currentDateTime());
}

void TestTreeItem::constructor()
{
    QFETCH(QVariant, data);

    auto item = createItem(data);
    QCOMPARE(item->data(), data);
}

void TestTreeItem::setData_data()
{
    QTest::addColumn<QVariant>("data");
    QTest::addColumn<int>("role");

    auto v = [](auto&& v){ return QVariant(v); };
    auto i = [](auto&& v){ return static_cast<int>(v); };

    QTest::newRow("1") << v("hello world") << i(Qt::DisplayRole);
    QTest::newRow("2") << v(2) << i(FooRole);
    QTest::newRow("3") << v(true) << i(BarRole);
    QTest::newRow("4") << v(QDateTime::currentDateTime()) << i(BazRole);
}

void TestTreeItem::setData()
{
    QFETCH(QVariant, data);
    QFETCH(int, role);

    auto item = createItem();
    item->setData(data, role);

    const auto outData = item->data(role);
    QVERIFY(data.isValid());
    QVERIFY(!data.isNull());
    QCOMPARE(outData, data);
}

void TestTreeItem::roles()
{
    auto item = createItem();
    item->setData(1, FooRole);
    item->setData(2, BarRole);

    const auto roles = item->roles();
    QCOMPARE(roles.size(), 2);
    QVERIFY(roles.contains(FooRole));
    QVERIFY(roles.contains(BarRole));
}

void TestTreeItem::itemData()
{
    auto item = createItem();
    item->setData(1, FooRole);
    item->setData(2, BarRole);

    const auto itemData = item->itemData();
    const auto dataMap = QMap<int, QVariant>{{
        { FooRole, 1 },
        { BarRole, 2 }
    }};
    QCOMPARE(itemData, dataMap);
}



QTEST_APPLESS_MAIN(TestTreeItem)

#include "tst_treeitem.moc"
