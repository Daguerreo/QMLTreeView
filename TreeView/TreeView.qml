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

    property alias handle: tree.handle
    property alias contentItem: tree.contentItem
    property Component highlight: Rectangle {
        color: root.selectedColor
    }

    property alias selectionEnabled: tree.selectionEnabled
    property alias hoverEnabled: tree.hoverEnabled

    property alias color: tree.color
    property alias handleColor: tree.handleColor
    property alias hoverColor: tree.hoverColor
    property alias selectedColor: tree.selectedColor
    property alias selectedItemColor: tree.selectedItemColor

    enum Handle {
        Triangle,
        TriangleSmall,
        TriangleOutline,
        TriangleSmallOutline,
        Chevron,
        Arrow
    }

    property int handleStyle: TreeView.Handle.Triangle
    property alias fontMetrics: tree.fontMetrics
    property alias font: tree.font
    property alias rowPadding: tree.rowPadding
    property alias rowHeight: tree.rowHeight

    contentHeight: tree.height
    contentWidth: parent.width
    boundsBehavior: Flickable.StopAtBounds
    ScrollBar.vertical: ScrollBar {}

    Connections { function onCurrentIndexChanged() { currentData = model.data(currentIndex) }  }

    TreeViewItem {
        id: tree

        model: root.model
        parentIndex: model.rootIndex()
        childCount: model.rowCount(parentIndex)

        itemLeftPadding: 0
        color: root.color
        handleColor: root.handleColor
        hoverColor: root.hoverColor
        selectedColor: root.selectedColor
        selectedItemColor: root.selectedItemColor
        defaultIndicator: indicatorToString(handleStyle)
        z: 1
    }

    Loader {
        id: highlightLoader
        sourceComponent: highlight

        width: root.width
        height: root.rowHeight
        z: 0
        visible: root.selectionEnabled && tree.currentItem !== null

        Binding {
            target: highlightLoader.item
            property: "y"
            value: tree.currentItem ? tree.currentItem.mapToItem(tree, 0 ,0).y + tree.anchors.topMargin : 0
            when: highlightLoader.status === Loader.Ready
        }
    }

    function indicatorToString(handle){
        switch (handle){
        case TreeView.Handle.Triangle: return "▶";
        case TreeView.Handle.TriangleSmall: return "►";
        case TreeView.Handle.TriangleOutline: return "▷";
        case TreeView.Handle.TriangleSmallOutline: return "⊳";
        case TreeView.Handle.Chevron: return "❱";
        case TreeView.Handle.Arrow: return "➤";
        default: return "▶";
        }
    }
}
