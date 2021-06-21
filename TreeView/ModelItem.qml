import QtQuick 2.15

Row {
    id: root

    property alias text: contentData.text
    property string color: "black"

    spacing: 10

    Text {
        id: contentData

        anchors.verticalCenter: parent.verticalCenter
        color: root.color
        font.pixelSize: 20
    }
}
