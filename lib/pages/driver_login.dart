import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Widgets/loadingScreen.dart';

class driverLogin extends StatefulWidget {
  const driverLogin({Key? key}) : super(key: key);

  @override
  State<driverLogin> createState() => _driverLoginState();
}

class _driverLoginState extends State<driverLogin> {

  String driver_email='';
  String driver_pass='';
  String driver_name='';
  String driver_phone='';
  String driver_car='';

  Future createUser ({required String name, required String email, required String phone, required String driver_car}) async  {
    final docUser=FirebaseFirestore.instance.collection('drivers').doc();

    final user=User(
        id: docUser.id,
        name: name,
        email: email,
        phone: phone,
        driver_car: driver_car
    );
    final json=user.toJson();
    await docUser.set(json);
  }

  Future writeUser(User user) async {
    print(1);
    final docUser = FirebaseFirestore.instance.collection('drivers').doc();
    print(2);
    user.id=docUser.id;
    print(3);

    final json=user.toJson();
    print(4);
    await docUser.set(json);
    print(5);
  }

  Future registerDriver() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return progressIndicator(message: "Registration in progress");
        }
    );
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: driver_email, password: driver_pass);
      final user=User(
          name: driver_name,
          email: driver_email,
          phone: driver_phone,
          driver_car: driver_car
      );
      writeUser(user);
      Navigator.pushNamed(context, 'driver_login_main');
    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Driver Register'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Center(
                  // child: CircleAvatar(
                  //   backgroundImage: AssetImage('assets/main_logo.jpeg'),
                  //   radius: 50,
                  // ),
                  child: Lottie.network("https://assets6.lottiefiles.com/packages/lf20_e2r6dsye.json"),
                  heightFactor: 0.35,
                ),
                SizedBox(height: 30.0),
                Container(
                  height: 470,
                  decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            driver_email=value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                        child: TextField(
                          obscureText: true,
                          onChanged: (value) {
                            driver_pass=value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.key),
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                        child: TextField(
                          onChanged: (value) {
                            driver_name=value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                        child: TextField(
                          onChanged: (value) {
                            driver_phone=value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.phone_android),
                              hintText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                        child: TextField(
                          onChanged: (value) {
                            driver_car=value;
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.car_repair),
                              hintText: 'Car Model',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                        child: TextButton(
                          onPressed: registerDriver,
                          child: Text('Register as Driver'),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(Colors.amber)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  String id;
  final String name;
  final String email;
  final String phone;
  final String driver_car;

  User({
    this.id='',
    required this.name,
    required this.email,
    required this.phone,
    required this.driver_car,
  });

  Map<String,dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'driver_car': driver_car,
  };
}
