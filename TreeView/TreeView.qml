import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Flickable {
    id: root

    property var model

    property alias indicator: tree.indicator
    property alias contentItem: tree.contentItem
    property alias selectionEnable: tree.selectionEnabled
    property alias hoverEnabled: tree.hoverEnabled

    property color color: "black"
    property color handleColor: color
    property color hoverColor: "lightgray"
    property color selectedColor: "silver"
    property color selectedItemColor: color

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
        hoverColor: root.hoverColor
        selectedColor: root.selectedColor
        selectedItemColor: root.selectedItemColor

    }
}
