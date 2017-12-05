import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0

ApplicationWindow {
    id: window
    width: 500
    height: 700
    visible: true
    title: "Fantasybit"
    property  bool first: true

    property string  fontfamFB:  "Helvetica Neue"
    property string nameStatsText: ""
    property bool doimport: false
    property bool doverify: false


    property var pages:     [ "Account",  "Secret", "Bitcoin", "Balance"  ]
    property var altpages: [ "Fantasy Name",  "Brain Wallet", "Bitcoin Address", "Transactions and Balances"  ]


    Material.theme: Material.Light
    Material.accent: "#0080A6"// Material.Amber
    Material.primary: "#0E3656"//BlueGreyMaterial.Blue
//    Material.foreground: Material.BlueGrey// "#F3F3F3" //Material.BlueGrey// "#FAFAFA"
//    Material.background: "#F3F3F3"
//    Material.
//    Material.Blue


    header:  ToolBar {

//        Material.background: "blue"
        height: first  ? 0 : implicitHeight
        visible: !first
        Material.foreground: Material.background
        id: toobar
//        BuyButton {}
        RowLayout {
            spacing: 20
            anchors.fill: parent

            Label {
                id: titleLabel
//                textFormat: Text.RichText
//                text: "ƑantayɃit<sup>+Skill</sup> Sale"
                text: (!tabBar || tabBar.currentIndex < 0) ? "" : pages[tabBar.currentIndex]
                font.pixelSize: 16
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
//                font.family: fontfamFB
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        ToolTip {
            id: tt
            parent: stackView.currentItem
        }


        initialItem: Pane {
            id: pane

            Material.theme:  Material.Dark
            ColumnLayout {
                id: columnLayout2
                clip: false
                anchors.topMargin: 5
                spacing: 8
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter


//                Label {
//                    width: parent.width
//                    wrapMode: Label.Wrap
//                    horizontalAlignment: Qt.AlignHCenter
//                    text: "Fantasy name is your public id and Fantasybit wallet address, some use their twitter handle others remain anonymous"
//                    Component.onCompleted: {
//                        console.log(parent.width)
//                    }
//                }

                Label {
                    id: label1
                    text: qsTr("Welcome to Fantasybit Skill Coin Sale ")
                    Layout.columnSpan: 4
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 17
                    font.bold: true
                    textFormat: Text.RichText
                    horizontalAlignment: Text.AlignHCenter
                    enabled: true
                }

//                BusyIndicator {
//                    anchors.centerIn: parent
//                    running: !button1.enabled
//                }

                RowLayout {
                    id: rowLayout3
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    Image {
                        id: image1
                        fillMode: Image.PreserveAspectFit
                        source: "FantsyBitLogoSmall.png"
                    }

                    ColumnLayout {
                        id: columnLayout1
                        width: 100
                        height: 100
                        Layout.rowSpan: 2
                        Layout.columnSpan: 3

                        RowLayout {
                            id: rowLayout1
                            width: 100
                            height: 100
                            Layout.columnSpan: 2

                            Label {
                                id: price
                                text: qsTr(".00001")
                                font.bold: true
                                font.pixelSize: 14
                            }

                            Label {
                                id: btc
                                text: qsTr("BTC")
                                font.bold: true
                                font.pixelSize: 14
                                verticalAlignment: Text.AlignVCenter
                            }
                        }

                        RowLayout {
                            id: rowLayout2
                            width: 100
                            height: 100

                            Label {
                                id: available
                                text: Number(Math.round(CoinSale.totalAvailable,10)).toLocaleString(Qt.locale("en-US"),'f',0)
                                font.pixelSize: 12
                                verticalAlignment: Text.AlignVCenter
                            }

                            Label {
                                id: label2
                                text: qsTr("available")
                                font.pixelSize: 12
                                Layout.columnSpan: 1
                                Layout.rowSpan: 1
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                     Button {
                        id: button1
                        text: enabled ? "BUY" : "..."
                        enabled: CoinSale.totalAvailable > 0
                        onClicked: {
                            CoinSale.buy()
                        }
                    }
                }

            }
        }
    }



    BusyIndicator {
        id: busy
        anchors.centerIn: parent
        running: CoinSale.busySend
    }

   Label {
       Material.foreground: Material.Red

        rotation: -45
        text: "Demo Testing"
//        color: Material.Red.toString()//"#40000000"
        anchors.centerIn: parent
        font.pixelSize: 20
        font.bold:  true
        visible: CoinSale.isTestNet
//        font.pixelSize: ProtoScreen.font( ProtoScreen.XXLARGE)
//        anchors.fill: parent
    }


    footer:
        Column {
        width: parent.width
        spacing: 15

        ProgressBar {
            Material.foreground: Material.Red
            id: pbar
            width: parent.width // (stackView.width / 3 ) * 2
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: !window.first
            visible: enabled
            value: 0
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 18
                color: "#f9d7d7"//#e6e6e6"
                radius: 3
            }
            contentItem: Item {
                implicitWidth: 200
                implicitHeight: 12

                Rectangle {
                    width: pbar.visualPosition * parent.width
                    height: parent.height
                    radius: 2
                    color: "#17a81a"
                }
            }
        }


        TabBar {
        property int prev: -1
        id: tabBar
        visible: !window.first
        enabled: !window.first
        Layout.preferredHeight:  window.first ? 0 : implicitHeight
        width: parent.width
        Layout.fillWidth: true
        currentIndex: -1
        Repeater {
            model: window.first ? 0 : pages.length;
            TabButton {
                text: pages[index]
                font.pixelSize: 10
            }
        }


//        TabButton {
//            text: pages[0]
//            font.pixelSize: 10
//        }

        onCurrentIndexChanged: {
            console.log("TAb current index changed" + currentIndex);
            if ( !window.first) {

                if ( prev !== currentIndex ) {
                    if( prev+1 == currentIndex) {
                        prev = currentIndex
                        stackView.push("qrc:/" + pages[currentIndex] + ".qml");
                    }
                    else if ( prev-1 == currentIndex) {
                        prev = currentIndex
                        stackView.pop();
                    }
                    currentIndex = prev;
                }
//                currTitle = pages[currentIndex];
//                stackView.replace("qrc:/" + pages[currentIndex] + ".qml")
            }
        }

   }


        ToolBar {
            Material.foreground: Material.Grey
            width: parent.width
            Layout.fillWidth: true;
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
    //            anchors.fill: parent
                anchors.centerIn: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                Layout.fillWidth: true;

    //            width: parent.width
                spacing: 5
                padding: 5
//                Label {
//                    anchors.verticalCenter: parent.verticalCenter
//    //                anchors.horizontalCenter: parent.horizontalCenter
//                    id: logarea3
//                    text: "..."
//        //            anchors.bottom: parent.bottom
//        //            horizontalAlignment: Text.AlignLeft
//                    font.pixelSize: 10
////                    Layout.fillWidth: true;
//                }

                Label {
        //            anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    id: logarea2
                    text: "..."
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 10

                    Layout.fillWidth: true;

        //            anchors.bottom: logarea.top
                }
                Label {
                    anchors.verticalCenter: parent.verticalCenter

        //            anchors.horizontalCenter: parent.horizontalCenter
                    id: logarea
                    text: "..."
        //            anchors.bottom: parent.bottom
        //            horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 10
                    Layout.fillWidth: true;

                }

            }

        }
    }

    Connections {
        target: CoinSale
        property var pagemap: []

        function startupFunction() {
            for (var i = 0; i < pages.length; i++) {
                    pagemap[pages[i]] = i;
            }
        }

        Component.onCompleted: startupFunction();

        onCurrDialogChanged: {
            if ( window.first )
                window.first = false;

           var nexti = -1;
           switch  ( currDialog ) {
               case "name":
                   nexti = pagemap["Account"];
                   break;
               case "fund":
                   nexti = pagemap["Bitcoin"];
                   if ( CoinSale.secretIsVerified )
                       pbar.value = .50;
                   break;
               case "secret":
                   doverify = false;
                   doimport = false;
                   nexti = pagemap["Secret"];
                   pbar.value = .25;
                   break;
               case "secretverify":
                   doverify = true;
                   nexti = pagemap["Secret"];
                   break;
               case "secretimport":
                   doimport = true;
                   nexti = pagemap["Secret"];
                   break;

               case "balance":
                   nexti = pagemap["Balance"];
                   pbar.value = .75;
                   break;
               case "done":
                   nexti = pagemap["Balance"];
                   pbar.value = 1;
                   break;
               default:
                   console.log("unknown currDialog" + currDialog)
//                   nexti = pagemap["Balance"];
                   break;

           }

           if ( nexti > -1 ) {
               console.log(" nexti " + currDialog + nexti)
               tabBar.setCurrentIndex(nexti);
           }
        }

        onNameCheckGet: {
            console.log( "namehcek " + name + status)
            if(status === "true" ) {
                window.nameStatsText = "name Check Pass... sending claim name tx to blockchain for: " + name;
                toobar.ToolTip.show(window.nameStatsText ,5000)
                CoinSale.signPlayer(name);
            }
            else if ( status === "false"){
                window.nameStatsText = name + " not Available - try new name or import"
//                stackView.ToolTip.show(window.nameStatsText ,10000)
                  toobar.ToolTip.show(window.nameStatsText ,5000)

            }
            else {
                window.nameStatsText = name + ": " + status
                toobar.ToolTip.show(window.nameStatsText ,6000)
            }
        }

        onCurrStatusChanged: {
//            logarea3.text = logarea2.text
            logarea2.text = logarea.text
            logarea.text = "... " + currStatus
//            logarea.text = currStatus;
//            logarea.append(currStatus + "\n")
//            logarea.text = currStatus + "\n" + logarea.text;
        }
    }


}

