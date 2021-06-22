import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root

    visible: true
    width: 500
    height: 400
    title: qsTr("Simplified TreeView")

    // This is a simplified TreeView with a Flickable with the TreeItem.
    // If you need the component as is just use this example, otherwise go for
    // the TreeView example

    Flickable {
        id: treeView

        anchors.fill: parent
        contentHeight: tree.height
        contentWidth: parent.width
        boundsBehavior: Flickable.StopAtBounds
        ScrollBar.vertical: ScrollBar {}

        TreeItem {
            id: tree

            anchors {
                top: parent.top
                left: parent.left
                leftMargin: 5
                topMargin: 5
            }

            model: treeModel
            parentIndex: treeModel.rootIndex()
            childCount: treeModel.rowCount(parentIndex)

            itemLeftPadding: 0
            color: "black"
        }
    }
}
