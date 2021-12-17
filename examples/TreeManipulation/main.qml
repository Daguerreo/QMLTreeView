import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Window {
    width: 500
    height: 400
    visible: true
    title: qsTr("Hello World")


    ColumnLayout {
        anchors.fill: parent


        TreeView {
            id: treeView

            Layout.fillWidth: true
            Layout.fillHeight: true

            model: treeModel
            selectionEnabled: true

            onCurrentIndexChanged: if(currentIndex) console.log("current index is (row=" + currentIndex.row + ", depth=" + model.depth(currentIndex) + ")")
            onCurrentDataChanged: if(currentData) console.log("current data is " + currentData)
            onCurrentItemChanged: if(currentItem) console.log("current item is " + currentItem)

        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            MenuSeparator {
                Layout.fillWidth: true
            }

            TextArea {
                id: txtEdit

                Layout.fillWidth: true

                placeholderText: "Write data to add..."

                function notEmpty() { return text !== ""}
                function clear() { text = "" }
            }

            Row {
                Layout.margins: 8
                spacing: 16

                Button {
                    id: addBtn
                    text: "Add top level item"
                    enabled: txtEdit.notEmpty()

                    onClicked: {
                        treeManipulator.addTopLevelItem(txtEdit.text)
                        txtEdit.clear()
                    }
                }

                Button {
                    id: addChildBtn
                    text: "Add child item"
                    enabled: txtEdit.notEmpty() && treeView.currentItem

                    onClicked: {
                        treeManipulator.addItem(treeView.currentIndex, txtEdit.text)
                        txtEdit.clear()
                    }
                }

                Button {
                    id: delBtn
                    text: "Remove item"
                }
                Button {
                    id: clearBtn
                    text: "Clear"

                    onClicked:  {
                        treeManipulator.reset();
                    }
                }
            }
        }
    }
}
