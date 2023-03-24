import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

Window {
    id: root
    function getData() {
    listview.model.clear()
    var xmlhttp = new XMLHttpRequest();
        var count = 5;
    var url = "https://pokeapi.co/api/v2/ability/7/";
        var url2 = "https://pokeapi.co/api/v2/ability/150/";
        var url3 = "https://pokeapi.co/api/v2/pokemon-form/132/";
        var url4 = "https://pokeapi.co/api/v2/version/1/";
        var url5 = "https://pokeapi.co/api/v2/version/3/";
        var list = [url,url2,url3,url4,url5];
        for(var i = 0; i < count; i++)
        {
    xmlhttp.onreadystatechange = function() {
    if (xmlhttp.readyState == XMLHttpRequest.DONE && xmlhttp.status == 200) {
    print(xmlhttp.responseText)
    listview.model.append( {listdata: xmlhttp.responseText})

    //parseStaff(xmlhttp.responseText);
    }
    }
    xmlhttp.open("GET", list[i], true);
    xmlhttp.send();
        }
    }

    function parseStaff(response) {
    var jsonObj = JSON.parse(JSON.parse(response));
    var jsonStaff = jsonObj.staff
    for(var i = 0; i < jsonStaff.length; i++) {
    listview.model.append( {listdata: jsonStaff[i].name +" "+ jsonStaff[i].age + " " + jsonStaff[i].position})
    }
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
