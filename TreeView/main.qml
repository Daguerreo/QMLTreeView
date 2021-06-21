import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root

    visible: true
    width: 500
    height: 400
    title: qsTr("Simplified TreeView")

    Row {
        anchors.fill: parent

        Rectangle {
            id: treePart

            width: parent.width
            height: parent.height
            border {
                width: 1
                color: "gray"
            }
            clip: true

            TreeView {
                anchors.fill: parent
                model: treeModel
                color: "#3c85b5"
            }
        }
    }
}
