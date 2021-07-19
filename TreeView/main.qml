import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: root

    visible: true
    width: 800
    height: 400
    title: qsTr("TreeView with TreeModel")

    TreeView {
        id: jsonView
        anchors.fill: parent
        anchors.margins: 1

        model: jsonModel
        rowPadding: 20
        selectionEnabled: true

        contentItem: RowLayout {
            Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                text: currentRow.currentData.key
            }

            Text {
                Layout.fillWidth: true
                Layout.rightMargin: 10

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                text: currentRow.currentData.value ? currentRow.currentData.value : ""
            }
        }
    }

    //    Row {
    //        anchors.fill: parent

    //        Rectangle {
    //            width: parent.width / 3
    //            height: parent.height
    //            border.width: 1
    //            border.color: "black"
    //            clip: true

    //            // Default TreeView

    //            TreeView {
    //                id: defaultTreeView

    //                anchors.fill: parent
    //                anchors.margins: 1

    //                model: treeModel

    //                selectionEnabled: true
    //                hoverEnabled: true
    //            }
    //        }

    //        Rectangle {
    //            width: parent.width / 3
    //            height: parent.height
    //            border.width: 1
    //            border.color: "black"
    //            clip: true

    //            // Styled TreeView

    //            TreeView {
    //                id: styledTreeView

    //                anchors.fill: parent
    //                anchors.margins: 1

    //                model: treeModel
    //                selectionEnabled: true
    //                hoverEnabled: true

    //                color: "steelblue"
    //                handleColor: "steelblue"
    //                hoverColor: "skyblue"
    //                selectedColor: "cornflowerblue"
    //                selectedItemColor: "white"
    //                handleStyle: TreeView.Handle.Chevron
    //                rowHeight: 40
    //                rowPadding: 30
    //                rowSpacing: 12
    //                font.pixelSize: 24

    //                onCurrentIndexChanged: console.log("current index is (" + currentIndex.row + "," + currentIndex.column + ")")
    //                onCurrentDataChanged: console.log("current data is " + currentData)
    //                onCurrentItemChanged: console.log("current item is " + currentItem)
    //            }
    //        }

    //        Rectangle {
    //            width: parent.width / 3
    //            height: parent.height
    //            border.width: 1
    //            border.color: "black"
    //            clip: true

    //            // TreeView with custom delegate

    //            TreeView {
    //                id: delegateTreeView
    //                anchors.fill: parent
    //                anchors.margins: 1

    //                model: treeModel
    //                selectionEnabled: true

    //                contentItem: Row {
    //                    spacing: 10

    //                    Rectangle {
    //                        width: parent.height * 0.6
    //                        height: width
    //                        radius: width
    //                        y: width / 3
    //                        color: currentRow.hasChildren ? "tomato" : "lightcoral"
    //                    }

    //                    Text {
    //                        verticalAlignment: Text.AlignVCenter

    //                        color: currentRow.isSelectedIndex ? delegateTreeView.selectedItemColor : delegateTreeView.color
    //                        text: currentRow.currentData
    //                        font: delegateTreeView.font
    //                    }
    //                }

    //                handle: Item {
    //                    width: 20
    //                    height: 20
    //                    Rectangle {
    //                        anchors.centerIn: parent
    //                        width: 10
    //                        height: 2
    //                        color: "black"
    //                        visible: currentRow.hasChildren

    //                        Rectangle {
    //                            anchors.centerIn: parent
    //                            width: parent.height
    //                            height: parent.width
    //                            color: parent.color
    //                            visible: parent.visible && !currentRow.expanded
    //                        }
    //                    }
    //                }

    //                highlight: Item {
    //                    Rectangle {
    //                        color: "pink"
    //                        width: parent.width * 0.9
    //                        height: parent.height
    //                        anchors.left: parent.left
    //                        radius: 60
    //                    }
    //                    Rectangle {
    //                        color: "pink"
    //                        width: parent.width * 0.2
    //                        height: parent.height
    //                        anchors.right: parent.right
    //                        radius: 60
    //                    }

    //                    Behavior on y { NumberAnimation { duration: 150 }}
    //                }
    //            }
    //        }
    //    }

}
