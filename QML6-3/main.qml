import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Window {
    id: root
    function getData() {
    listview.model.clear()
    var xmlhttp = new XMLHttpRequest();
    var url = "https://api.openweathermap.org/data/2.5/weather?lat=51.667710&lon=39.216426&appid=3a1c877b1633ad2cdb636524ee3e078f";
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
    listview.model.append( { listdata: "Погода: " +jsonObj.weather.main + " Описание: " + jsonObj.weather.description})
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
