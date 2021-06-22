import QtQuick 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

Item {
    id: root

    // model properties
    property var model
    property var parentIndex
    property var childCount
    property var currentIndex: null

    // layout properties
    property int itemLeftPadding: 0
    property int childLeftPadding: 30
    property color color: "black"
    property color handleColor: color
    property color hoverColor: "lightgray"
    property bool hoverEnabled: false

    implicitWidth: parent.width
    implicitHeight: childrenRect.height

    ColumnLayout {
        width: parent.width
        spacing: 10

        Repeater {
            model: childCount
            Layout.fillWidth: true

            delegate: ColumnLayout {
                id: itemColumn

                Layout.leftMargin: itemLeftPadding

                spacing: 10

                QtObject {
                    id: _prop

                    property var currentIndex: root.model.index(index, 0, parentIndex)
                    property var currentData: root.model.data(currentIndex)
                    property var itemChildCount: root.model.rowCount(currentIndex)
                    property bool expanded: false
                    readonly property bool hasChildren: itemChildCount > 0
                    readonly property bool isCurrentIndex: _prop.currentIndex === root.currentIndex

                    function toggle(){
                        if(_prop.hasChildren) _prop.expanded = !_prop.expanded
                    }
                }

                ColumnLayout {
                    id: column

                    Layout.fillWidth: true

                    width: row.implicitWidth
                    height: row.implicitHeight
                    spacing: 10

                    Rectangle {
                        id: rowOverlay
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: _prop.isCurrentIndex ? hoverColor : "transparent"

                        RowLayout {
                            id: row

                            Layout.fillWidth: true

                            spacing: 10

                            // Indicator
                            Rectangle {
                                id: indicator

                                implicitWidth: 20
                                implicitHeight: 20
                                rotation: _prop.expanded ? 90 : 0
                                opacity: _prop.hasChildren
                                color: "transparent"

                                Label {
                                    anchors.centerIn: parent
                                    text: "❱"
                                    antialiasing: true
                                    color: handleColor
                                }

                                TapHandler { onSingleTapped:  _prop.toggle() }
                            }

                            //  Content
                            Row {
                                spacing: 10

                                Rectangle {
                                    id: squareIndicator
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 8
                                    height: 40
                                    color: root.color
                                }


                                Text {
                                    id: contentData

                                    anchors.verticalCenter: parent.verticalCenter
                                    color: root.color
                                    font.pixelSize: 20
                                    text: _prop.currentData

                                }
                            }

                        }
                        HoverHandler {
                            onHoveredChanged: {
                                if(root.hoverEnabled){
                                    if(hovered) root.currentIndex = _prop.currentIndex
                                    else root.currentIndex = null
                                }
                            }

                        }
                        TapHandler { onDoubleTapped: _prop.toggle() }
                    }
                }

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

                    Binding {
                        target: loader.item;
                        property: "color";
                        value: root.color
                        when: loader.status == Loader.Ready
                    }
                    Binding {
                        target: loader.item;
                        property: "handleColor";
                        value: root.handleColor
                        when: loader.status == Loader.Ready
                    }
                    Binding {
                        target: loader.item;
                        property: "hoverColor";
                        value: root.hoverColor
                        when: loader.status == Loader.Ready
                    }
                    Binding {
                        target: loader.item;
                        property: "hoverEnabled";
                        value: root.hoverEnabled
                        when: loader.status == Loader.Ready
                    }
                }
            }
        }
    }
}
