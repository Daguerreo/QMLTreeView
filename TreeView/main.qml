import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root

    visible: true
    width: 800
    height: 400
    title: qsTr("TreeView with TreeModel")

    Row {
        anchors.fill: parent

        Rectangle {
            width: parent.width / 3
            height: parent.height
            border.width: 1
            border.color: "black"
            clip: true

            // Default TreeView

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
            width: parent.width / 3
            height: parent.height
            border.width: 1
            border.color: "black"
            clip: true

            // Styled TreeView

            TreeView {
                id: styledTreeView

                anchors.fill: parent
                anchors.margins: 1

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

        Rectangle {
            width: parent.width / 3
            height: parent.height
            border.width: 1
            border.color: "black"
            clip: true

            // TreeView with custom delegate

            TreeView {
                id: delegateTreeView
                anchors.fill: parent
                anchors.margins: 1

                model: treeModel
                selectionEnable: true

                highlight: Item {
                    Rectangle {
                        color: "pink"
                        width: parent.width * 0.9
                        height: parent.height
                        anchors.left: parent.left
                        radius: 60
                    }
                    Rectangle {
                        color: "pink"
                        width: parent.width * 0.2
                        height: parent.height
                        anchors.right: parent.right
                        radius: 60
                    }
                }
            }
        }
    }
}
