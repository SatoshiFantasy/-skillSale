//import QtQuick 2.7

//Page1Form {
//    button1.onClicked: {
//        console.log("Button Pressed. Entered text: " + textField1.text);
//    }
//}


import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
//    property alias textField1: textField1
    property alias button1: button1
    property alias nameStatsText: nameStatusL.text

    ColumnLayout {
        id: col1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        anchors.top: parent.top
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            TextField {
                id: claimNametext
                placeholderText: qsTr("Enter Fantasy Name")
            }

            Button {
                id: claimButton
                text: qsTr("Claim")
                onClicked: {
                    nameCheckBlank(claimNametext.text);
                }
            }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 50

//            TextField {
//                id: textField1
//                placeholderText: qsTr("Enter 12 word Secret")
//            }

            Button {
                height: 50
                id: button1
                text: "Import name using secrert"
                onClicked: {
                    insec.visible = true;
//                    if ( textField1.text !== '')
//                        CoinSale.doimport(textField1.text)
                }
            }
        }
        RowLayout {
            anchors.horizontalCenter: parent.horizontalCenter;
            Label {
                id: nameStatusL
                text: "..."
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            border.color: "black"
            width: parent.width
            height: insec.implicitHeight
            SecretPage {
                anchors.fill: parent
                id: insec
                isimport: true
                visible: false
            }
        }
    }

    function nameCheckBlank(s) {
        if ( s.trim().length === 0 ) {
            nameStatusL.text = "please enter a fantasy name "
        }
        else if ( s.length > 45) {
            nameStatusL.text = "name to long "
        }
        else {
            nameStatusL.text = s + " checking name available.";
            CoinSale.checkname(s)
        }
    }

}