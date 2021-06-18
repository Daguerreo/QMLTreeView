import QtQuick 2.15

Row {
    id: root

    property alias text: contentData.text
    property string color: "black"

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
