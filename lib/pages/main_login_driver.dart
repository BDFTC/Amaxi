import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/loadingScreen.dart';

class driverLoginMain extends StatefulWidget {
  const driverLoginMain({Key? key}) : super(key: key);

  @override
  State<driverLoginMain> createState() => _driverLoginMainState();
}

class _driverLoginMainState extends State<driverLoginMain> {

  String driver_email='';
  String driver_pass='';

  Future LoginDriver() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return progressIndicator(message: "Registration in progress");
        }
    );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: driver_email, password: driver_pass);
      Navigator.pushNamed(context, 'driver_dashboard');
    }
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Driver Login'),
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
                  //   radius: 80,
                  // ),
                  child: Lottie.network("https://assets5.lottiefiles.com/packages/lf20_jol43osd.json"),
                  heightFactor: 0.7,
                ),
                SizedBox(height: 50.0),
                Container(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  height: 400,
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
                        child: TextButton(
                          onPressed: LoginDriver,
                          child: Text('Login'),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              backgroundColor: MaterialStateProperty.all(Colors.amber)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0,right: 35.0,top: 15.0),
                        child: Row(
                          children: [
                            Text("Don't have an account?", style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white54,
                            ),
                            ),
                            TextButton(onPressed: () {
                              // Navigate to driver registration
                              Navigator.pushNamed(context, 'driver_login');
                            },
                                child: Text('Sign Up',style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.amber
                                ))
                            ),
                          ],
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
