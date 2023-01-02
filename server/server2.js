const path = require('path')
const bodyParser = require('body-parser')
import { initializeApp } from 'firebase/app'
import { getDatabase } from "firebase/database";

const firebaseApp = initializeApp({
    apiKey: "AIzaSyD359pL2WsKIFLwYiLUONHtV5HCQT8vXWE",
    authDomain: "amaxi-51d05.firebaseio.com",
    projectId: "amaxi-51d05",
    storageBucket: "amaxi-51d05.appspot.com",
    messagingSenderId: ""
});

//driverHas Email, Password, Name, phoneNumber, carModel

const database = getDatabase();

function writeUserData(driverId, name, email, password, phoneNumber, carModel) {
  const db = getDatabase();
  set(ref(db, 'driver/' + userId), {
    name: name,
    email: email,
    password: password,
    phoneNumber: phoneNumber,
    carModel: carModel
  });
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


