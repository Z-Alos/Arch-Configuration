import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import SddmComponents 2.0

Rectangle {
    id: root
    anchors.fill: parent
    color: "#E700EF"

    property date currentTime: new Date()

    function doLogin() {
        errorMessage.text = ""
        sddm.login(userModel.lastUser, password.text, sessionModel.lastIndex)
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: currentTime = new Date()
    }

    Image {
        anchors.fill: parent
        source: "assets/login_bg.png"
        fillMode: Image.PreserveAspectCrop
        opacity: 0.85
    }

    // Time
    Text {
        text: Qt.formatDateTime(currentTime, "h:mm")
        font.pixelSize: 169
        font.family: "JetBrains Mono"
        color: "#FFFFFF"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -220
    }

    // Date
    Text {
        text: Qt.formatDateTime(currentTime, "dddd, MMMM d")
        font.pixelSize: 30
        font.family: "JetBrains Mono"
        color: "#FFFFFF"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -120
    }

    // Profile picture
    Rectangle {
        width: 170
        height: 170
        radius: width / 2
        border.width: 8
        border.color: "#DDB6F2"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 30
        clip: true

        Image {
            anchors.fill: parent
            source: "assets/profile.jpg"
            fillMode: Image.PreserveAspectCrop
        }
    }

    // Password field
    Rectangle {
        width: 250
        height: 50
        radius: 15
        color: "#FFFFFF"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 160

        TextField {
            id: password
            anchors.fill: parent
            anchors.margins: 10
            background: null
            echoMode: TextInput.Password
            placeholderText: "Password"
            font.pixelSize: 16
            font.family: "JetBrains Mono"
            horizontalAlignment: Text.AlignHCenter
            focus: true

            Keys.onReturnPressed: doLogin()
            Keys.onEnterPressed: doLogin()
        }
    }

    // Error message
    Text {
        id: errorMessage
        text: ""
        color: "#FF4D4D"
        font.pixelSize: 14
        font.family: "JetBrains Mono"
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        anchors.top: parent.verticalCenter
        anchors.topMargin: 210
        opacity: text === "" ? 0 : 1

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    Connections {
        target: sddm

        onLoginFailed: {
            password.text = ""
            errorMessage.text = "Wrong password"
            password.forceActiveFocus()
        }

        onInformationMessage: {
            errorMessage.text = message
        }
    }
}

