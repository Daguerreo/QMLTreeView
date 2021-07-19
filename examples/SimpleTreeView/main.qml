import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
   id: root

   visible: true
   width: 400
   height: 400
   title: qsTr("Simple TreeView")

   Rectangle {
      anchors.fill: parent
      border.width: 1
      border.color: "black"
      clip: true

      TreeView {
         id: defaultTreeView

         anchors.fill: parent
         anchors.margins: 1

         model: treeModel

         onCurrentIndexChanged: console.log("current index is (row=" + currentIndex.row + ", depth=" + model.depth(currentIndex) + ")")
         onCurrentDataChanged: console.log("current data is " + currentData)
         onCurrentItemChanged: console.log("current item is " + currentItem)
      }
   }
}
