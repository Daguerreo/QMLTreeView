import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Flickable {
    id: root

    property var model
    property string color: "black"
    property string handleColor: color

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

        model: root.model
        parentIndex: model.rootIndex()
        childCount: model.rowCount(parentIndex)

        itemLeftPadding: 0
        color: root.color
        handleColor: root.handleColor
    }
}
