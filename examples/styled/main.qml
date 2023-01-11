import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import QMLTreeView 1.0

Window {
    id: root

    visible: true
    width: 400
    height: 400
    title: qsTr("Styled TreeView")

    TreeView {
        id: styledTreeView

        anchors.fill: parent
        anchors.margins: 1

        model: treeModel
        selectionEnabled: true
        hoverEnabled: true

        color: "steelblue"
        handleColor: "steelblue"
        hoverColor: "skyblue"
        selectedColor: "cornflowerblue"
        selectedItemColor: "white"
        handleStyle: TreeView.Handle.Chevron
        rowHeight: 40
        rowPadding: 30
        rowSpacing: 12
        font.pixelSize: 20

        onCurrentIndexChanged: console.log("current index is (row=" + currentIndex.row + ", depth=" + model.depth(currentIndex) + ")")
        onCurrentDataChanged: console.log("current data is " + currentData)
        onCurrentItemChanged: console.log("current item is " + currentItem)
    }
}
