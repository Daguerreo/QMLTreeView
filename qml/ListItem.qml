import QtQuick 2.14
import QtQuick.Controls 2.14

Item {
    id: root

    property int itemLeftPadding: 30

    anchors.fill: parent

    Component.onCompleted: {
        fillData()
    }

    ListModel {
        id: listItemModel
    }

    ListView {
        id: listArea

        anchors.fill: parent
        spacing: 10
        boundsBehavior: Flickable.StopAtBounds
        ScrollBar.vertical: ScrollBar {}

        model: listItemModel
        delegate: Column {
            width: parent.width
            spacing: 10

            ModelItem {
                text: name
            }

            Rectangle {
                anchors {
                    left: parent.left
                    leftMargin: -100
                    right: parent.right
                }

                width: parent.width
                height: 1
                color: "gray"
                opacity: 0.5
            }
        }
    }

    function fillData() {
        let rootIndex = treeModel.rootIndex()

        for(var i = 0; i < treeModel.rowCount(rootIndex); i++) {
            let index =treeModel.index(i, 0, rootIndex)
            listItemModel.append({"name":  treeModel.data(index)})
            fillFromBranch(index)
        }
    }

    function fillFromBranch(modelIndex) {
        let childCount = treeModel.rowCount(modelIndex)

        if (childCount > 0) {
            for (var i = 0; i < childCount; i++) {
                let index =treeModel.index(i, 0, modelIndex)
                listItemModel.append({"name":  treeModel.data(index)})
                fillFromBranch(index)
            }
        }
    }
}
