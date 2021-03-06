import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0
import Qt.labs.settings 1.0

Pane {

    id: secretpage

    TextEdit {
        id: cliphelper
        visible: false
    }

    TextEdit {
        id: pasthelper
        visible: false
    }


    property var secretWordsIn: {
        return !isdisplay ? pastWordsin : CoinSale.secretShow.split(" ");
    }

    property var pastWordsin: []

    property bool isimport: window.doimport && !CoinSale.secretIsVerified
    property bool isverify: window.doverify && !CoinSale.secretIsVerified
    property bool isdisplay: !isimport && !isverify
    property var secretOut: []
    property bool didcopy: false

    property bool didpaste: false

    onIsdisplayChanged: {
//        console.log("onIsdisplayChanged " + isdisplay)

//        grid.update()

//        if ( !isdisplay ) {
//            secretWordsIn = []
//            grid.update()
//        }
//        else {
//            if ( CoinSale.secretShow !== "" ) {
//                secretWordsIn = CoinSale.secretShow.split(" ");
//            }
//        }
    }

    readonly property int itemWidth:  (secretpage.availableWidth / 3) * 2


    Column {
        anchors.fill: parent
        spacing: 40
        anchors.horizontalCenter: parent.horizontalCenter

        Column {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: (secretpage.width / 6) *5

            Label {
    //            width: parent.width
                wrapMode: Label.Wrap
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Qt.AlignHCenter
                width: (secretpage.width / 6) *5

    //            text: "A tool tip is a short piece of text that informs the user of a control's function."
                text: isdisplay ?
                          ( CoinSale.secretIsVerified ?
                               "Write down your 12 word recover secret!"
                             :
                               "Step 2: Write down your 12 word recover secret!"  )
                        :  (  isverify ?
                                "Step 2: Verify secret words."
                            :
                                "Step 1: Import secret words.");
            }

            Label {
                wrapMode: Label.Wrap
                anchors.horizontalCenter: parent.horizontalCenter
                width: (secretpage.width / 6) *5

                text: isdisplay ?
                          ( CoinSale.secretIsVerified ?
                               "These words are needed to obtain your Fantsybits and to recover stuck bitcoins. Hint: Click to copy secret to clipboard"
                             :
                               "These words are needed to obtain your Fantsybits and to recover stuck bitcoins. Hint: Click to copy secret to clipboard" )
                        :  (  isverify ?
                                "Type in or paste (right click) your 12 secret words, your bain wallet. Verify your brain wallet before sending bitcoin to funding address!"
                            :
                                "Type in or paste (right click) your 12 secret words, your bain wallet. Verify your brain wallet before sending bitcoin to funding address! ");

                font.pixelSize: 12
            }
        }


        Frame {
            anchors.horizontalCenter: parent.horizontalCenter
            id: rec1

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                width: itemWidth

                GridView {
                    width: parent.width
                    implicitHeight: 200
                    id: grid
    //                anchors.fill: parent
                    cellHeight: 200 / 6
                    cellWidth: itemWidth / 2

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    model: 12
                    delegate: secretDelegate
                    MouseArea {
        //                enabled:!(isimport || isverify )
                        id: ma
                        anchors.fill: parent
                        onClicked: {
                            if ( isdisplay ) {
                                console.log("copying ")
                                cliphelper.text = CoinSale.secretShow
                                console.log("copying 2")

                                cliphelper.selectAll()
                                cliphelper.cut()
                                console.log("copying3 ")

        //                        cliphelper.
        //                        cliphelper.text = ""
        //                        rec1.ToolTip.visible = true
                                console.log("copying4 ")
                                rec1.ToolTip.show("Secret Copied to Clipboard" ,5000)
//                                CoinSale.toolPop("Secret Copied to Clipboard");

        //                        tt.visible = true;

                                didcopy = true
                            }
                            else {
                                pasthelper.text = ""
                                pasthelper.paste()
                                console.log("pste " + pasthelper.text)
                                pastWordsin = pasthelper.text.trim().split(" ")

//                                secretWordsIn = Qt.binding(function() {
//                                    return pasthelper.text.trim().split(" ");
//                                });

                                console.log("PASTING3 ")


        //                        cliphelper.text = ""
        //                        rec1.ToolTip.visible = true
        //                        ToolTip.timeout = 5000
        //                        ToolTip.text =  "Secret Pasted from Clipboard"
        //                        ToolTip.visible = true
        //                        didpaste = true
        //                        grid.update
//                                  CoinSale.toolPop("Secret Pasted from Clipboard")
                                rec1.ToolTip.show("Secret Pasted from Clipboard" ,5000)
        //                        tt.visible = true;
                                console.log("PASTING4 ")
        //                        ToolTip.show("")
                            }
                        }

                        acceptedButtons: !isdisplay ? Qt.RightButton : Qt.LeftButton

        //                ToolTip.timeout: 5000
        //                ToolTip.text: isdisplay ? "Secret Copied to Clipboard" : "Secret Pasted from Clipboard"
        //                ToolTip.visible: pressed

                    }

                }
            }
        }

        Column {
//            anchors.top: rec1.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10;
            Button {

                id: button1
                enabled: !CoinSale.secretIsVerified //CoinSale.currName === "" ||  isverify
//                visible: !CoinSale.secretIsVerified
                text: isimport ? "Import" : ( isverify ? "Verify Secret" : "OK got it!")
                onClicked: {
                    if ( !isdisplay ) {
                        var words = secretOut.join(" ")  ;
                        console.log("clicked: " + words)
                        if ( words !== "" ) {
                            if ( isimport) {
                                console.log("try import")

                                rec1.ToolTip.show("Try Import" ,500)

//                                CoinSale.toolPop("try import");
//                                rec1.ToolTip.show("try import" ,500)
                                CoinSale.doimport(words);
                            }
                            else {
                                console.log("try verify")
//                                toobar.ToolTip.show("try verify" ,500)
                                console.log("try verify 2")

                                CoinSale.verify(words);
                                console.log("try verify 3")

                            }
                        }
                        else {
//                            rec1.ToolTip.show("bad import" ,2000)
//                            CoinSale.toolPop("bad import");
                            rec1.ToolTip.show("Bad Import" ,2000)

                            CoinSale.set_currStatus("bad import")
                        }
                    }
                    else {
                        if ( didcopy ) {
                            cliphelper.text = "secret cleared from clipboard"
                            cliphelper.selectAll()
                            cliphelper.copy()
                            cliphelper.text = ""
                        }

                        CoinSale.secretOk();
                    }
                }
//                visible: isimport
                anchors.horizontalCenter: parent.horizontalCenter
                width: itemWidth / 2.5
            }

            Text {
                    id: forgotbut
                    enabled: isverify
                    visible: isverify

//                    anchors.topMargin: 10
//                    anchors.top: col1.bottom
//                    anchors.horizontalCenter: parent.horizontalCenter
                    textFormat: Text.RichText
                    text: "Forgot secret?  <a href=\"import\">Click to recover</a>"
                    font.pixelSize: 10
                    onLinkActivated: {
                        CoinSale.forgot()
                    }
            }
        }
    }


    Component {
        id: secretDelegate

        Item {
            width: grid.cellWidth
            height: grid.cellHeight

            RowLayout {
//            anchors.margins: 2
                height: parent.height
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

//                anchors.centerIn: parent
                Label {
                    height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: -2
//                    anchors.left: parent.left
//                    height: parent.height
                    Layout.preferredWidth: parent.width * .20
                    id: lb
                    text: (index < 9 ? " " : "") +(index+1) + ": "
                    font.pixelSize: 16

                }
                TextField {
                    height: parent.height
//                    anchors.bottom:
                    anchors.verticalCenter: parent.verticalCenter
//                    horizontalAlignment: Text.AlightLeft
                    verticalAlignment: Text.AlignBottom
                    font.pixelSize: 16
//                    verticalAlignment: Qt.AlignBottom

//                    height: parent.height
//                    anchors.verticalCenter: parent.verticalCenter
//                    anchors.left: lb.right
//                    width: parent.width - lb.width
                    text: (secretWordsIn.length <= index) ? "" :  secretWordsIn[index]

                        //(secretpage.isimport || secretpage.isverify || secretWordsIn.length < 12) ? "" : secretWordsIn[index]
                    font.bold: true
                    readOnly: secretpage.isdisplay
//                    onEditingFinished: {
//                        console.log("editing finished" + text)
//                        secretOut[index] = text
//                    }

                    onTextChanged: {
                        console.log(index + "text changed " + text)
                        secretOut[index] = text
                    }
                }
            }
        }
    }
}
