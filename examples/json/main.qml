import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import QMLTreeView 1.0

Window {
   id: root

   visible: true
   width: 400
   height: 400
   title: qsTr("Json TreeView")

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
}
