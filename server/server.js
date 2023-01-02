const path = require('path')
const bodyParser = require('body-parser')
const { initializeApp } = require('firebase/app')
const { getDatabase, ref, set, child, get } = require("firebase/database")
// const { get } = require('http')
var admin = require("firebase-admin");

var serviceAccount = require("./serviceAccountKey.json");
var placeCoordinates = [
    [76.75124201279625, 30.728236491597823],
    [76.72927199143861, 30.747064501611757],
    [76.6999204261629, 30.734430103716143],
    [76.64661714715938, 30.73122472707027],
    [76.8104981000791, 30.7449068259825],
    [76.6024981000791, 30.7929068259825],
    [76.6024981000791, 30.7449068259825],
    [76.58276136610599, 30.713619201119533],
    [76.54854811461628, 30.703607844458176]
]

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://amaxi-51d05.firebaseio.com',
    authDomain: 'amaxi-51d05.firebaseapp.com'
});

const driverIdCollectionId = "356CJdsCMwffLhV9SDx6";

const db = admin.firestore();

function writeDriverData(parameter, location) {
  set(ref(db, 'driver/' + userId), {
    name: parameter.name,
    email: parameter.email,
    phone: parameter.phone,
    driver_car: parameter.driver_car,
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

async function readDriver(driverId){
    const driversRef = db.collection("drivers");
    const response = await driversRef.get();
    let responseArr = [];
    response.forEach(doc => {
        responseArr.push(doc.data());
        // console.log(doc.data());
    })
    return responseArr;
}
async function writeDriver(driverId, locationGiven){
    const driversRef = db.collection("drivers");
    // driversRef.doc(driverId).update({location:locationGiven});
}

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

var driverCoordinates = [];
function getAccidentListFromModel() {
    var date_obj = new Date(); //gets today's date
    var hours = date_obj.getHours();
    var minutes = date_obj.getMinutes();


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
        console.log("driver coordinates predicted")
        console.log(driverCoordinates)

    });
    return driverCoordinates;
}

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
const driverIds = readDriver(driverIdCollectionId);
driverIds.then((data) =>{
    var requiredObject = data[0];
    var accidentList = getAccidentListFromModel();
    writeDriver(requiredObject, accidentList)
});
