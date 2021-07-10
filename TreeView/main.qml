import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root

    visible: true
    width: 500
    height: 400
    title: qsTr("TreeView with TreeModel")

    Row {
        anchors.fill: parent

        Rectangle {
            width: parent.width / 2
            height: parent.height
            border.width: 1
            border.color: "black"
            clip: true

            TreeView {
                id: defaultTreeView
                anchors.fill: parent
                anchors.margins: 1
                model: treeModel

                selectionEnable: true
                hoverEnabled: true
            }
        }

        Rectangle {
            width: parent.width / 2
            height: parent.height
            border.width: 1
            border.color: "black"
            clip: true

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
                indicatorStyle: TreeView.Indicator.Chevron

                onCurrentIndexChanged: console.log("current index is (" + currentIndex.row + "," + currentIndex.column + ")")
                onCurrentDataChanged: console.log("current data is " + currentData)
                onCurrentItemChanged: console.log("current item is " + currentItem)
            }
        }
    }
}
