import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root

    enum Shape {
        Triangle = 0,
        Chevron,
        Arrow
    }

    property int margin: 4
    property bool expanded: false
    property int shape: Handle.Shape.Triangle
    property string color: "black"

    implicitWidth: 20
    implicitHeight: 20
    rotation: expanded ? 90 : 0

    Text {
        id: name

        anchors.centerIn: parent
        color: root.color
        antialiasing: true
        text: {
            switch (shape){
            case Handle.Shape.Triangle:
                return "▶";
            case Handle.Shape.Chevron:
                return "❱"
            case Handle.Shape.Arrow:
                return "➤";
            default:
                return "▶";
            }
        }
    }

}
