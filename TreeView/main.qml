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
        id: treeview
        anchors.fill: parent
        model: treeModel

        selectionEnable: true
        hoverEnabled: true

        color: "steelblue"
        hoverColor: "skyblue"
        selectedColor: "dodgerblue"
        selectedItemColor: "white"
    }
}
