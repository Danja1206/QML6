import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Window {
    id: root
    function getData() {
    listview.model.clear()
    var xmlhttp = new XMLHttpRequest();
    var url = "https://currate.ru/api/?get=rates&pairs=USDRUB,EURRUB&key=0689e51ff277245eb7481d8c2816b1ba";
    xmlhttp.onreadystatechange = function() {
    if (xmlhttp.readyState == XMLHttpRequest.DONE && xmlhttp.status == 200) {
    print(xmlhttp.responseText)
   // listview.model.append( {listdata: xmlhttp.responseText})

    parseStaff(xmlhttp.responseText);
    }
    }
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
        }

    function parseStaff(response) {
    var jsonObj = JSON.parse(response);
        print(jsonObj.data.USDRUB)
    var jsonStaff = jsonObj.staff
    listview.model.append( { listdata: "Доллар: " +jsonObj.data.USDRUB + " руб. Евро: " + jsonObj.data.EURRUB + "руб"})
    }
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

Item {
anchors.fill: parent
ListModel {
id:model
}
ListView {
id: listview
anchors.fill: parent
model: model
header: Rectangle {
height: 35
width: parent.width
color: "dark green"
Text {
anchors.centerIn: parent
text: "Данные с сервера"
color: "white"
}
}
delegate: Rectangle {
    width: parent.width
    height: 30
    Text {
        text:listdata
        anchors.centerIn: parent
    }
}
}
}
Button {
    anchors.bottom: parent.bottom
    width: parent.width
    text: "Подтянуть"
    onClicked: getData()
}
}
