import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root

    visible: true
    width: 640
    height: 480
    title: qsTr("TreeModel collapsed in a ListView")

    Rectangle {
        id: listPart

        width: parent.width
        height: parent.height
        border {
            width: 1
            color: "gray"
        }
        clip: true

        CollapsedTreeView {
            anchors {
                top: parent.top
                left: parent.left
                leftMargin: 5
                topMargin: 5
            }

            model: treeModel

            color: "#1C1C1C"
        }
    }


}
