import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import QMLTreeView 1.0

Window {
   id: root

   visible: true
   width: 400
   height: 400
   title: qsTr("Custom Delegate")

   TreeView {
         id: delegateTreeView
         anchors.fill: parent
         anchors.margins: 1

         model: treeModel
         selectionEnabled: true

         contentItem: Row {
            spacing: 10

            Rectangle {
               width: parent.height * 0.6
               height: width
               radius: width
               y: width / 3
               color: currentRow.hasChildren ? "tomato" : "lightcoral"
            }

            Text {
               verticalAlignment: Text.AlignVCenter

               color: currentRow.isSelectedIndex ? delegateTreeView.selectedItemColor : delegateTreeView.color
               text: currentRow.currentData
               font: delegateTreeView.font
            }
         }

         handle: Item {
            width: 20
            height: 20
            Rectangle {
               anchors.centerIn: parent
               width: 10
               height: 2
               color: "black"
               visible: currentRow.hasChildren

               Rectangle {
                  anchors.centerIn: parent
                  width: parent.height
                  height: parent.width
                  color: parent.color
                  visible: parent.visible && !currentRow.expanded
               }
            }
         }

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

            Behavior on y { NumberAnimation { duration: 150 }}
         }

         onCurrentIndexChanged: console.log("current index is (row=" + currentIndex.row + ", depth=" + model.depth(currentIndex) + ")")
         onCurrentDataChanged: console.log("current data is " + currentData)
         onCurrentItemChanged: console.log("current item is " + currentItem)
      }


}
