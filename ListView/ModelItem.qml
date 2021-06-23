import QtQuick 2.15

Column {
    id: root

    property alias text: contentData.text
    property string color: "black"

    spacing: 10

    Row {
        spacing: 10

        Rectangle {
            id: squareIndicator
            anchors.verticalCenter: parent.verticalCenter
            width: 20
            height: 20
            color: root.color
        }

        Text {
            id: contentData

            anchors.verticalCenter: parent.verticalCenter
            color: root.color
            font.pixelSize: 20
        }
    }

    Rectangle {
        id: rowSeparator
        anchors {
            left: parent.left
            right: parent.right
        }

        width: parent.width
        height: 1
        color: "gray"
        opacity: 0.5
    }
}


