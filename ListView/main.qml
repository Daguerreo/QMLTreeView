import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root

    visible: true
    width: 640
    height: 480
    title: qsTr("TreeModel collapsed in a ListView")

    CollapsedTreeView {
        anchors.fill: parent

        model: treeModel
        color: "#1F1F1F"
    }

}
