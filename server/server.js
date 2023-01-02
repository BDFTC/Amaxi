const path = require('path')
const bodyParser = require('body-parser')
import { initializeApp } from 'firebase/app'
import { getDatabase } from "firebase/database";
import { get } from 'http';

const firebaseApp = initializeApp({
    apiKey: "AIzaSyD359pL2WsKIFLwYiLUONHtV5HCQT8vXWE",
    authDomain: "amaxi-51d05.firebaseio.com",
    projectId: "amaxi-51d05",
    storageBucket: "amaxi-51d05.appspot.com",
    messagingSenderId: ""
});

//driverHas Email, Password, Name, phoneNumber, carModel

const database = getDatabase();

function writeDriverData(driverId, name, email, password, phoneNumber, carModel) {
  const db = getDatabase();
  set(ref(db, 'driver/' + userId), {
    name: name,
    email: email,
    password: password,
    phoneNumber: phoneNumber,
    carModel: carModel
  });
}

function calculateDistance(latitude1, latitude2, longitude1, longitude2) { //in Km
    var latitude1Radians = latitude1 / 57.29577951;
    var latitude2Radians = latitude2 / 57.29577951;
    var longitude1Radians = longitude1 / 57.29577951;
    var longitude2Radians = longitude2 / 57.29577951;
    var difference = longitude2Radians - longitude1Radians;
    var distance = 3963 * Math.acos((Math.sin(latitude2Radians) * Math.sin(latitude2Radians)) + Math.cos(latitude1Radians) * Math.cos(latitude2Radians) * Math.cos(difference));
    return distance;
}


const dbRef = ref(database);
get(child(dbRef, `driver/${driverId}`)).then((snapshot) => {
  if (snapshot.exists()) {
    console.log(snapshot.val());
  } else {
    console.log("No data available");
  }
}).catch((error) => {
    console.error(error);
});

function calculateLongitudeLatitude(long1, lat1, distance) {
    var brng = Math.random() * Math.PI * 2;
    if (brng == 0) {
        brng == 0.1
    }

    var R = 6378.1; // radius of earth
    var d = distance / 1000; // in km
    console.log(d);
    var lat1Radian = lat1 * (Math.PI) / 180;
    var long1Radian = long1 * (Math.PI) / 180;
    var lat2 = Math.asin(Math.sin(lat1Radian) * Math.cos(d / R) + Math.cos(lat1Radian) * Math.sin(d / R) * Math.cos(brng));
    var long2 = long1Radian + Math.atan2(Math.sin(brng) * Math.sin(d / R) * Math.cos(lat1Radian),
        Math.cos(d / R) - Math.sin(lat1Radian) * Math.sin(lat2))

    var lat2Degree = lat2 * 180 / Math.PI;
    var long2Degree = long2 * 180 / Math.PI;

    return [lat2Degree, long2Degree];

}

function getAccidentListFromModel() {
    var date_obj = new Date(); //gets today's date
    var hours = date_obj.getHours();
    var minutes = date_obj.getMinutes();

    const driverCoordinates = [];

    var total = (60 * hours + minutes);
    var counterTillNow = Math.floor(total / 15);
    timeCurrent = 0.01041 * counterTillNow;
    const {
        spawn
    } = require('child_process');
    const pyProg = spawn('python', ['./accidentModel/model.py']);

    pyProg.stdin.write(timeCurrent.toString());

    pyProg.stdin.end();

    pyProg.stdout.on('data', function(data) {

    console.log(data.toString());
    var tempData = JSON.parse(data);
    for (var i = 0; i < tempData.length; i++) {

        var arrayLatLong = calculateLongitudeLatitude(placeCoordinates[tempData[i][0]][1], placeCoordinates[tempData[i][0]][0], tempData[i][1]);
        // var temporaryLatitude=placeCoordinates[tempData[i][0]][1]+(tempData[i][1])/111111;
        // var temporaryLongitude=placeCoordinates[tempData[i][0]][0]+(tempData[i][1])/(111111* Math.cos(Math.PI*placeCoordinates[tempData[i][0]][1])/180);
        driverCoordinates.push([arrayLatLong[0], arrayLatLong[1]]);
    }

    });
    return driverCoordinates;
}

function getAllDatabaseValues(){} //returns ALL DRIVER OBJECTS

function requiredDriver(){
    var allDriverObject = getAllDatabaseValues();
    var accidentModelLocation = getAccidentListFromModel();

    for (const location in accidentModelLocation){
        var minimum = -1;
        var minProperty = null;
        for (const property in allDriverObject) {
            var distance = calculateDistance();
            if(distance > minimum){
                minimum = calculateDistance()
                minProperty = property;
            }    
        }
        minProperty.x = y; //change this too
        writeDriverData(minProperty);//add required variables in driver

    }
}
