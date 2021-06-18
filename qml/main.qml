import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "./"

Window {
    id: root

    visible: true
    width: 640
    height: 480
    title: qsTr("TreeView and ListView example")

    Row {
        anchors.fill: parent
        spacing: -1

        Rectangle {
            id: treePart

            width: parent.width / 2
            height: parent.height
            border {
                width: 1
                color: "gray"
            }
            clip: true

            Flickable {
                id: toolbarFlickable

                anchors.fill: parent
                contentHeight: tree.height
                contentWidth: parent.width
                boundsBehavior: Flickable.StopAtBounds
                ScrollBar.vertical: ScrollBar {}

                TreeItem {
                    id: tree

                    anchors {
                        top: parent.top
                        left: parent.left
                        leftMargin: 5
                        topMargin: 5
                    }

                    model: treeModel
                    parentIndex: treeModel.rootIndex()
                    childCount: treeModel.rowCount(parentIndex)

                    itemLeftPadding: 0
                    color: "#3c85b5"
                }
            }
        }

        Rectangle {
            id: listPart

            width: parent.width / 2
            height: parent.height
            border {
                width: 1
                color: "gray"
            }
            clip: true

            ListItem {
                anchors {
                    top: parent.top
                    left: parent.left
                    leftMargin: 5
                    topMargin: 5
                }

                itemLeftPadding: 0
            }
        }
    }
}
