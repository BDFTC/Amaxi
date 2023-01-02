import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class homePageDriver extends StatefulWidget {
  const homePageDriver({Key? key}) : super(key: key);

  @override
  State<homePageDriver> createState() => _homePageDriverState();
}

class _homePageDriverState extends State<homePageDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Home Screen Driver'),
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
                  child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_mzgntrue.json"),
                  heightFactor: 0.5,
                ),
                SizedBox(height: 40.0),
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
                                child: Text('Sign in',style: TextStyle(
                                    fontSize: 28,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'driver_login_main');
                                  },
                                  icon: Icon(Icons.local_taxi),
                                  label: Text('Driver'),
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(Colors.white),
                                      backgroundColor: MaterialStateProperty.all(Colors.amber)
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                                child: Text('Sign Up',style: TextStyle(
                                    fontSize: 28,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'driver_login');
                                  },
                                  icon: Icon(Icons.local_taxi_outlined),
                                  label: Text('Driver'),
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(Colors.white),
                                      backgroundColor: MaterialStateProperty.all(Colors.amber)
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
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
                              onPressed: () async{
                                final url='https://en.wikipedia.org/wiki/Privacy_policy';

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
                        onPressed: () async{
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
                        onPressed: () async{
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
