import QtQuick 2.15
import QtQuick.Layouts 1.15

Column {
    id: root

    property alias handle: indicator
    property alias text: modelItem.text
    property alias color: modelItem.color

    property bool expanded: false
    property string handleColor: color

    width: row.implicitWidth
    height: row.implicitHeight
    spacing: 10

    signal toggle()

    Row {
        id: row
        width: parent.width
        spacing: 10

        Rectangle {
            id: indicator

            anchors.verticalCenter: parent.verticalCenter
            opacity: 0
            implicitWidth: 20
            implicitHeight: 20
            rotation: expanded ? 90 : 0

            Text {
                anchors.centerIn: parent
                text: "▶"
                antialiasing: true
                color: handleColor
            }

            TapHandler { onSingleTapped:  root.toggle() }
        }

        ModelItem {
            id: modelItem
            text: "dummy"
            color: root.color
        }
    }
}
