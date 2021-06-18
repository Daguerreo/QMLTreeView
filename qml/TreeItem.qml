import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    // model properties
    property var model
    property var parentIndex
    property var childCount

    // layout properties
    property int itemLeftPadding: 30
    property string color: "black"
    property string handleColor: color

    implicitWidth: parent.width
    implicitHeight: childrenRect.height

    QtObject {
        id: separator

        property int height: 1
        property string color: "gray"
        property real opacity: 0.5
        property bool visible: false
    }

    ColumnLayout {
        width: parent.width
        spacing: 10

        Repeater {
            model: childCount

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

                    function toggle(){
                        if(_prop.hasChildren) _prop.expanded = !_prop.expanded
                    }
                }

                Delegate {
                    id: theDelegate

                    Layout.fillWidth: true
                    text: _prop.currentData
                    color: root.color

                    handle.opacity: _prop.hasChildren
                    handle.expanded: _prop.expanded

                    onToggle: _prop.toggle()

                    TapHandler {
                        onDoubleTapped: _prop.toggle()
                    }
                }

                Rectangle {
                    id: separatorRect

                    Layout.fillWidth: true
                    Layout.leftMargin: -100
                    width: parent.width
                    height: separator.height
                    color: separator.color
                    opacity: separator.opacity
                    visible: separator.visible
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
                }
            }
        }
    }
}
