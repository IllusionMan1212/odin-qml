import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: app
    title: "Hello World [ODIN]- Example"
    width: 300; height: 200
    color: "lightgray"
    Component.onCompleted: visible = true

	FontLoader {
		id: redHatDisplay
		source: "./fonts/RedHatDisplay.ttf"
	}

	font.family: redHatDisplay.name
	// font.pointSize: 24

	TextArea {
		text: "Hello world!\n Qml on Odin"
		readOnly: true
		selectByMouse: true
		font.pointSize: 16
	}
    Text {
        text: "Hello world!\n Qml on Odin"
        y: 30
        anchors.horizontalCenter: app.contentItem.horizontalCenter
        font.pointSize: 24;
    }

    menuBar: MenuBar {
            Menu {
                title: qsTr("File")
                MenuItem {
                    text: qsTr("&Open")
                    onTriggered: console.log("Open action triggered");
                }
                MenuItem {
                    text: qsTr("Exit")
                    onTriggered: Qt.quit();
                }
            }
    }

    Button {
		id: control
        text: qsTr("click bait")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter / 2

		// background: Rectangle {
		// 	implicitWidth: 150
		// 	implicitHeight: 40
		// 	color: control.hovered ? "#298238" : control.pressed ? "#2c3e50" : "#3498db"
		// 	radius: 0.2
		// 	border.color: control.activeFocus ? "#FF0000" : "#ffffff"
		// 	border.width: 2
		// }
    }
}
