import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQml 2.15

Flickable {
    id: root

    property var model
    readonly property alias currentIndex: tree.selectedIndex
    readonly property alias currentItem: tree.currentItem
    property var currentData

    property alias indicator: tree.indicator
    property alias contentItem: tree.contentItem
    property alias selectionEnable: tree.selectionEnabled
    property alias hoverEnabled: tree.hoverEnabled

    property color color: "black"
    property color handleColor: color
    property color hoverColor: "lightgray"
    property color selectedColor: "silver"
    property color selectedItemColor: color

    enum Indicator {
        Triangle,
        TriangleSmall,
        TriangleOutline,
        TriangleSmallOutline,
        Chevron,
        Arrow
    }

    property int indicatorStyle: TreeView.Indicator.Triangle

    property Component highlight: Rectangle {
        color: root.selectedColor
    }

    contentHeight: tree.height
    contentWidth: parent.width
    boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: ScrollBar {}

    Connections { function onCurrentIndexChanged() { currentData = model.data(currentIndex) }  }

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
        // @disable-check M16
        hoverColor: root.hoverColor
        // @disable-check M16
        selectedColor: root.selectedColor
        // @disable-check M16
        selectedItemColor: root.selectedItemColor
        // @disable-check M16
        defaultIndicator: indicatorToString(indicatorStyle)
        z: 1
    }

    Loader {
        id: highlightLoader
        sourceComponent: highlight

        width: root.width
        height: 24
        y: tree.currentItem ? tree.currentItem.mapToItem(tree, 0 ,0).y + tree.anchors.topMargin : 0
        z: 0
        active: tree.currentItem !== null
    }

    function indicatorToString(indicator){
        switch (indicator){
        case TreeView.Indicator.Triangle: return "▶";
        case TreeView.Indicator.TriangleSmall: return "►";
        case TreeView.Indicator.TriangleOutline: return "▷";
        case TreeView.Indicator.TriangleSmallOutline: return "⊳";
        case TreeView.Indicator.Chevron: return "❱";
        case TreeView.Indicator.Arrow: return "➤";
        default: return "▶";
        }
    }
}
