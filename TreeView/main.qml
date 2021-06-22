import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root

    visible: true
    width: 500
    height: 400
    title: qsTr("TreeView with TreeModel")

    TreeView {
        anchors.fill: parent
        model: treeModel
        color: "#3c85b5"
        hoverEnabled: true
        hoverColor: "skyblue"
    }
}
