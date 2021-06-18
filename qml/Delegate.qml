import QtQuick 2.15
import QtQuick.Layouts 1.15

Column {
    id: root

    property alias text: modelItem.text
    property alias handle: handle
    property alias color: modelItem.color

    width: row.implicitWidth
    height: row.implicitHeight
    spacing: 10

    signal toggle()

    Row {
        id: row
        width: parent.width
        spacing: 10

        Handle {
            id: handle

            anchors.verticalCenter: parent.verticalCenter
            opacity: 0
            expanded: false
            color: root.color

            TapHandler { onSingleTapped:  root.toggle() }
        }

        ModelItem {
            id: modelItem
            text: "dummy"
            color: root.color
        }
    }
}
