import 'package:amaxi/Maps/mapsUtil.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class userDashboard extends StatefulWidget {
  const userDashboard({Key? key}) : super(key: key);

  @override
  State<userDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<userDashboard> {

  // Coordinates -> Ready in python model
  double ?user_lat=30.641535; // lat of user
  double ?user_long=76.813496; // long of user
  double ?hosp_lat=30.7055; // lat for nearest hospital
  double ?hosp_long=76.8013; // long for nearest hospital

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('User Dashboard'),
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
                  //   radius: 100,
                  // ),
                  child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_W5Sk67.json",),
                  heightFactor: 1.2,
                ),
                SizedBox(height: 30.0),
                Container(
                  height: 400,
                  decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                                child: TextButton.icon(
                                  onPressed: () {
                                    // Book Ambulance and show Ambulance is on its way
                                    Fluttertoast.showToast(
                                        msg: "Looking for Ambulance",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.white,
                                        textColor: Colors.green,
                                        fontSize: 16.0
                                    );
                                    Navigator.pushNamed(context, 'user_book');
                                  },
                                  icon: Icon(Icons.local_hospital_outlined),
                                  label: Text('Book Ambulance'),
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(Colors.white),
                                      backgroundColor: MaterialStateProperty.all(Colors.red)
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                                child: TextButton.icon(
                                  onPressed: () {
                                    // Contact Us -> Maybe call 108 or company
                                    Fluttertoast.showToast(
                                        msg: "Calling 108",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.white,
                                        textColor: Colors.green,
                                        fontSize: 16.0
                                    );
                                  },
                                  icon: Icon(Icons.contact_phone_outlined),
                                  label: Text('Contact Us'),
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(Colors.white),
                                      backgroundColor: MaterialStateProperty.all(Colors.redAccent)
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                        child: Row(
                          children: [
                            Text("Don't know about us yet?",style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Can give link to a webpage about amaxi
                                final url='http://twitter.com';

                                if (await canLaunchUrl(Uri.parse(url))){
                                  await launch(url);
                                }
                              },
                              child: Text('Click here',style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blueGrey,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline
                              )),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          // give a link to utter shit
                          final url='http://twitter.com';

                          if (await canLaunchUrl(Uri.parse(url))){
                          await launch(url);
                          }
                        },
                        child: Text('Privacy Policy',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            color: Colors.blueGrey
                        ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          // give alink to utter bullshit
                          final url='http://twitter.com';

                          if (await canLaunchUrl(Uri.parse(url))){
                          await launch(url);
                          }
                        },
                        child: Text('Terma and Conditions',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            decoration:TextDecoration.underline,
                            color: Colors.blueGrey
                        ),
                        ),
                      )
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
