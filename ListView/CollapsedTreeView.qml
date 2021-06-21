import QtQuick 2.14
import QtQuick.Controls 2.14

Item {
    id: root

    property var model
    property string color: "black"

    anchors.fill: parent

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
                color: root.color
            }

            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                width: parent.width
                height: 1
                color: "gray"
                opacity: 0.5
            }
        }
    }

    Component.onCompleted: {
        fillData()
    }

    function fillData() {
        let rootIndex = model.rootIndex()

        for(var i = 0; i < model.rowCount(rootIndex); i++) {
            let index = model.index(i, 0, rootIndex)
            listItemModel.append({"name":  model.data(index)})
            fillFromBranch(index)
        }
    }

    function fillFromBranch(modelIndex) {
        let childCount = model.rowCount(modelIndex)

        if (childCount > 0) {
            for (var i = 0; i < childCount; i++) {
                let index = model.index(i, 0, modelIndex)
                listItemModel.append({"name":  model.data(index)})
                fillFromBranch(index)
            }
        }
    }
}
