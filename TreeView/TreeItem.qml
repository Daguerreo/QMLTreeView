import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    // model properties
    property var model
    property var parentIndex
    property var childCount

    property var selectedIndex
    property var hoveredIndex

    // layout properties
    property int itemLeftPadding: 0
    property int childLeftPadding: 30
    property color color: "black"
    property color handleColor: color

    property bool selectionEnabled: false
    property color selectedColor: "silver"
    property color selectedItemColor: color

    property bool hoverEnabled: false
    property color hoverColor: "lightgray"

    implicitWidth: parent.width
    implicitHeight: childrenRect.height

    // Components

    property Component indicator: Rectangle {
        id: indicator

        implicitWidth: 20
        implicitHeight: 20
        Layout.leftMargin: parent.spacing
        rotation: currentRow.expanded ? 90 : 0
        opacity: currentRow.hasChildren
        color: "transparent"

        Label {
            anchors.centerIn: parent
            text: "❱"
            antialiasing: true
            color: currentRow.isSelectedIndex ? root.selectedItemColor : root.handleColor
        }

        TapHandler { onSingleTapped: currentRow.toggle() }
    }

    property Component contentItem: Row {
        spacing: 10

        Text {
            id: contentData

            anchors.verticalCenter: parent.verticalCenter
            color: currentRow.isSelectedIndex ? root.selectedItemColor : root.color
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            text: currentRow.currentData
            height: Math.max(implicitHeight, 40)
        }
    }

    ColumnLayout {
        width: parent.width

        // spacing between children
        spacing: 6

        Repeater {
            model: childCount
            Layout.fillWidth: true

            delegate: ColumnLayout {
                id: itemColumn

                Layout.leftMargin: itemLeftPadding

                // space between parent and first children
                spacing: 6

                QtObject {
                    id: _prop

                    property var currentIndex: root.model.index(index, 0, parentIndex)
                    property var currentData: root.model.data(currentIndex)
                    property var itemChildCount: root.model.rowCount(currentIndex)
                    property bool expanded: false
                    property bool selected: false
                    readonly property bool hasChildren: itemChildCount > 0
                    readonly property bool isSelectedIndex: root.selectionEnabled && currentIndex === root.selectedIndex
                    readonly property bool isHoveredIndex: root.hoverEnabled && currentIndex === root.hoveredIndex
                    readonly property bool isSelectedAndHoveredIndex: hoverEnabled && selectionEnabled && isHoveredIndex && isSelectedIndex

                    function toggle(){
                        if(_prop.hasChildren) _prop.expanded = !_prop.expanded
                    }
                }

                ColumnLayout {
                    id: column

                    Layout.fillWidth: true

                    width: row.implicitWidth
                    height: row.implicitHeight
                    spacing: 0

                    Rectangle {
                        id: rowOverlay
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: {
                            if(_prop.isSelectedIndex) return root.selectedColor
                            else if(_prop.isHoveredIndex) return root.hoverColor
                            else return "transparent"
                        }

                        RowLayout {
                            id: row

                            Layout.fillWidth: true

                            spacing: 10

                            // indicator
                            Loader {
                                id: indicatorLoader
                                sourceComponent: indicator
                                Layout.leftMargin: parent.spacing

                                property QtObject currentRow: _prop
                            }

                            //  Content
                            Loader {
                                id: contentItemLoader
                                sourceComponent: contentItem

                                property QtObject currentRow: _prop
                            }
                        }
                        HoverHandler {
                            onHoveredChanged: {
                                if(root.hoverEnabled){
                                    if(hovered) root.hoveredIndex = _prop.currentIndex
                                    else root.hoveredIndex = null
                                }
                            }
                        }
                        TapHandler {
                            onDoubleTapped: _prop.toggle()
                            onSingleTapped: {
                                root.selectedIndex = _prop.currentIndex
                            }
                        }
                    }
                }

                // loader to populate the children row for each node
                Loader {
                    id: loader

                    width: parent.width
                    visible: _prop.expanded
                    source: "TreeItem.qml"
                    onLoaded: {
                        item.model = root.model
                        item.parentIndex = _prop.currentIndex
                        item.childCount = _prop.itemChildCount
                        item.itemLeftPadding = root.childLeftPadding
                    }

                    Binding { target: loader.item; property: "indicator"; value: root.indicator; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "contentItem"; value: root.contentItem; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "selectedIndex"; value: root.selectedIndex; when: loader.status == Loader.Ready }
                    Binding { target: root; property: "selectedIndex"; value: loader.item.selectedIndex; when: loader.status == Loader.Ready }

                    Binding { target: loader.item; property: "color"; value: root.color; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "handleColor"; value: root.handleColor; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "hoverEnabled"; value: root.hoverEnabled; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "hoverColor"; value: root.hoverColor; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "selectionEnabled"; value: root.selectionEnabled; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "selectedColor"; value: root.selectedColor; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "selectedItemColor"; value: root.selectedItemColor; when: loader.status == Loader.Ready }
                }
            }
        }
    }
}
