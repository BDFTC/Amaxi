import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../Widgets/loadingScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';


class userLogin extends StatefulWidget {
  const userLogin({Key? key}) : super(key: key);

  @override
  State<userLogin> createState() => _userLoginState();
}

class _userLoginState extends State<userLogin> {

  String user_email='';
  String user_pass='';
  String user_name='';
  String user_number='';

  Future createUser ({required String name, required String email, required String phone}) async  {
    final docUser=FirebaseFirestore.instance.collection('users').doc();

    final user=User(
      id: docUser.id,
      name: name,
      email: email,
      phone: phone
    );
    final json=user.toJson();
    await docUser.set(json);
  }

  Future writeUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id=docUser.id;

    final json=user.toJson();
    await docUser.set(json);
  }

  Future userRegister() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return progressIndicator(message: "Registration in progress");
        }
    );
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user_email, password: user_pass);
      final user=User(
        name: user_name,
        email: user_email,
        phone: user_number
      );
      writeUser(user);
      Navigator.pushNamed(context, 'main_login');
    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Cannot register");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('User Register'),
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
                  child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_wd1udlcz.json"),
                  heightFactor: 0.43,
                ),
                SizedBox(height: 30.0),
                Container(
                  height: 450,
                  decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value){
                            user_email=value;
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
                            user_pass=value;
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
                            user_name=value;
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
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            user_number=value; // Need to convert in int for use
                          },
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
                        child: TextButton(
                          onPressed: userRegister,
                          child: Text('Register as User'),
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

  User({
    this.id='',
    required this.name,
    required this.email,
    required this.phone
});

  Map<String,dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone
  };
}
