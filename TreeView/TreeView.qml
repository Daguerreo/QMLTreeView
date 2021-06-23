import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Flickable {
    id: root

    property var model
    readonly property alias currentIndex: tree.selectedIndex
    property var currentData

    property alias indicator: tree.indicator
    property alias contentItem: tree.contentItem
    property alias selectionEnable: tree.selectionEnabled
    property alias hoverEnabled: tree.hoverEnabled

    enum Indicator {
        Triangle,
        TriangleSmall,
        TriangleOutline,
        TriangleSmallOutline,
        Chevron,
        Arrow
    }

    property int indicatorStyle: TreeView.Indicator.Triangle
    property color color: "black"
    property color handleColor: color
    property color hoverColor: "lightgray"
    property color selectedColor: "silver"
    property color selectedItemColor: color

    Connections { function onCurrentIndexChanged() { currentData = model.data(currentIndex) }  }

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
        defaultIndicator: indicatorToString(indicatorStyle)
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
