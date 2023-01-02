import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class userBook extends StatefulWidget {
  const userBook({Key? key}) : super(key: key);

  @override
  State<userBook> createState() => _userBookState();
}

class _userBookState extends State<userBook> {

  int timeLeft=10;
  String text='Your Ambulance will arrive in';

  void _countDown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if(timeLeft>0){
        setState(() {
          timeLeft-=1;
          if(timeLeft==0){
            text='Your Ambulance has arrived! Hurry Up!';
          }
        });
      }
      else{
        timer.cancel();
        Fluttertoast.showToast(
            msg: "Your Ambulance has arrived! \nThanks for choosing us!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.white,
            textColor: Colors.green,
            fontSize: 16.0
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _countDown();
    print(timeLeft);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('User Book'),
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
                                child: Text(text,style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                                child: Text("${timeLeft} minutes",style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontSize: 20,
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
                                final url='https://devpost.com/';

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
                          final url='https://en.wikipedia.org/wiki/Privacy_policy';

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
                          final url='https://en.wikipedia.org/wiki/Terms_of_service';

                          if (await canLaunchUrl(Uri.parse(url))){
                            await launch(url);
                          }
                        },
                        child: Text('Terms and Conditions',style: TextStyle(
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
