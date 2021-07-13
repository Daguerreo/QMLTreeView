import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    // model properties

    property var model
    property var parentIndex
    property var childCount

    property var currentItem: null
    property var selectedIndex: null
    property var hoveredIndex: null

    // layout properties

    property bool selectionEnabled: false
    property bool hoverEnabled: false

    property int itemLeftPadding: 0
    property int childLeftPadding: 30
    property int rowHeight: 24

    property color color: "black"
    property color handleColor: color
    property color hoverColor: "lightgray"
    property color selectedColor: "silver"
    property color selectedItemColor: color

    property string defaultIndicator: "▶"
    property FontMetrics fontMetrics: FontMetrics {
        font.pixelSize: 20
    }
    property alias font: root.fontMetrics.font


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

        Text {
            anchors.centerIn: parent
            text: defaultIndicator
            font: root.font
            antialiasing: true
            color: currentRow.isSelectedIndex ? root.selectedItemColor : root.handleColor
        }
    }

    property Component contentItem: Text {
        id: contentData

        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter

        color: currentRow.isSelectedIndex ? root.selectedItemColor : root.color
        text: currentRow.currentData
        font: root.font
    }

    property Component hoverComponent: Rectangle {
        width: parent.width
        height: parent.height
        color: currentRow.isHoveredIndex && !currentRow.isSelectedIndex ? root.hoverColor : "transparent"
    }

    // Body

    ColumnLayout {
        width: parent.width

        // spacing between children
        spacing: 6

        Repeater {
            id: repeater
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
                    property Item currentItem: repeater.itemAt(index)
                    property var itemChildCount: root.model.rowCount(currentIndex)
                    property bool expanded: false
                    property bool selected: false
                    readonly property bool hasChildren: itemChildCount > 0
                    readonly property bool isSelectedIndex: root.selectionEnabled && currentIndex === root.selectedIndex
                    readonly property bool isHoveredIndex: root.hoverEnabled && currentIndex === root.hoveredIndex
                    readonly property bool isSelectedAndHoveredIndex: hoverEnabled && selectionEnabled && isHoveredIndex && isSelectedIndex

                    function toggle(){ if(_prop.hasChildren) _prop.expanded = !_prop.expanded }
                }

                Item {
                    id: column

                    Layout.fillWidth: true

                    width: row.implicitWidth
                    height: Math.max(row.implicitHeight, root.rowHeight)
                    clip: true

                    RowLayout {
                        id: row

                        anchors.fill: parent
                        z: 1

                        spacing: 10

                        // indicator
                        Loader {
                            id: indicatorLoader
                            sourceComponent: indicator
                            Layout.leftMargin: parent.spacing

                            property QtObject currentRow: _prop

                            TapHandler { onSingleTapped: _prop.toggle() }
                        }

                        //  Content
                        Loader {
                            id: contentItemLoader
                            sourceComponent: contentItem
                            Layout.fillWidth: true

                            property QtObject currentRow: _prop
                        }

                        TapHandler {
                            onDoubleTapped: _prop.toggle()
                            onSingleTapped: {
                                root.currentItem = _prop.currentItem
                                root.selectedIndex = _prop.currentIndex
                            }
                        }
                    }

                    Loader {
                        id: hoverLoader
                        sourceComponent: hoverComponent
                        width: row.width
                        height: parent.height
                        z: 0

                        property QtObject currentRow: _prop

                        HoverHandler {
                            onHoveredChanged: {
                                if(root.hoverEnabled){
                                    if(hovered) root.hoveredIndex = _prop.currentIndex
                                    else root.hoveredIndex = null
                                }
                            }
                        }
                    }

                }

                // loader to populate the children row for each node
                Loader {
                    id: loader

                    width: parent.width
                    visible: _prop.expanded
                    source: "TreeViewItem.qml"
                    onLoaded: {
                        item.model = root.model
                        item.parentIndex = _prop.currentIndex
                        item.childCount = _prop.itemChildCount
                        item.itemLeftPadding = root.childLeftPadding
                    }

                    Binding { target: loader.item; property: "indicator"; value: root.indicator; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "contentItem"; value: root.contentItem; when: loader.status == Loader.Ready }

                    Binding { target: loader.item; property: "currentItem"; value: root.currentItem; when: loader.status == Loader.Ready }
                    Binding { target: loader.item; property: "selectedIndex"; value: root.selectedIndex; when: loader.status == Loader.Ready }
                    Binding { target: root; property: "currentItem"; value: loader.item.currentItem; when: loader.status == Loader.Ready }
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
