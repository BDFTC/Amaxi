import 'package:amaxi/Maps/mapsUtil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_map/src/layer/marker_layer.dart' as marker;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map/plugin_api.dart';

class MapMarker {
        final String? image;
        final String? title;
        final latLng.LatLng location;

        MapMarker({
            this.image,
            required this.title,
            required this.location,
        });
}
class AppConstants {
  //anmol get these values
  static double user_lat = 30.641535; // lat of user
  static double user_long = 76.813496; // long of user
  static double hosp_lat = 30.7055; // lat for nearest hospital
  static double hosp_long = 76.8013; // long for nearest hospital
  static double driver_lat = 30.66332;
  static double driver_long = 76.8068;

  static String user_name = "Varun Kainthla";

  //ignore these values
  static String mapBoxAccessToken = 'YOUR_ACCESS_TOKEN';
  static String mapBoxStyleId = 'clcahnp7s000415r4b12il5mr';

  static final userLocation = latLng.LatLng(user_lat, user_long);

  static final mapMarkers = [
    MapMarker(
        title:'User Location',
        location: latLng.LatLng(user_lat, user_long),
    ),
    MapMarker(
        //image:'No.jpg',
        title:'Driver Location',
        location: latLng.LatLng(driver_lat, driver_long),
    ),
    MapMarker(
        title: "Hospital", 
        location:latLng.LatLng(hosp_lat, hosp_long)
    )
  ];
}

class userDashboard extends StatefulWidget {
  const userDashboard({Key? key}) : super(key: key);

  @override
  State<userDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<userDashboard> {

  List<marker.Marker> myMarker = <marker.Marker>[];

  // Coordinates -> Ready in python model
  void findDriverProcessStart(){

    setState(() {
      var mapMarker = AppConstants.mapMarkers;
      for (var i = 0; i < mapMarker.length; i++) {
        myMarker.add(
            marker.Marker(
                point: mapMarker[i].location,
                width: 100,
                height: 100,
                builder: (context) => Image.asset("assets/marker.png"),
            )
        );
              
    }
      print("Pressed BOIIIIIII");
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: Text("Hey " + AppConstants.user_name),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 13,
              center: AppConstants.userLocation,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/playermathinson/clcahnp7s000415r4b12il5mr/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicGxheWVybWF0aGluc29uIiwiYSI6ImNsMXFnMjRvbjEybHUza3BkanNjcTNxZjcifQ.JK4A3zEl7O9U7-8G48avag",
                additionalOptions: {
                   'mapStyleId': AppConstants.mapBoxStyleId,
                   'accessToken': AppConstants.mapBoxAccessToken,
                },
              ),
              MarkerLayer(
                markers : myMarker ,
              )
            ],
          ),
          ElevatedButton(
            onPressed: findDriverProcessStart, 
            child: Text("I need ambulance"),
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
            ),
          )

        ],
      ),
    );
  }
}

  //   return Scaffold(
  //     backgroundColor: Colors.lightBlueAccent,
  //     appBar: AppBar(
  //       title: Text('User Dashboard'),
  //       centerTitle: true,
  //       backgroundColor: Colors.cyan,
  //       elevation: 0.0,
  //     ),
  //     body: SingleChildScrollView(
  //       child: Container(
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 30.0),
  //           child: Column(
  //             children: [
  //               Center(
  //                 // child: CircleAvatar(
  //                 //   backgroundImage: AssetImage('assets/main_logo.jpeg'),
  //                 //   radius: 100,
  //                 // ),
  //                 child: Lottie.network("https://assets10.lottiefiles.com/packages/lf20_W5Sk67.json",),
  //                 heightFactor: 1.2,
  //               ),
  //               SizedBox(height: 30.0),
  //               Container(
  //                 height: 400,
  //                 decoration: BoxDecoration(color: Colors.cyan,borderRadius: BorderRadius.circular(50)),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Column(
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
  //                               child: TextButton.icon(
  //                                 onPressed: () {
  //                                   // Book Ambulance and show Ambulance is on its way
  //                                   Fluttertoast.showToast(
  //                                       msg: "Looking for Ambulance",
  //                                       toastLength: Toast.LENGTH_SHORT,
  //                                       gravity: ToastGravity.CENTER,
  //                                       backgroundColor: Colors.white,
  //                                       textColor: Colors.green,
  //                                       fontSize: 16.0
  //                                   );
  //                                   Navigator.pushNamed(context, 'user_book');
  //                                 },
  //                                 icon: Icon(Icons.local_hospital_outlined),
  //                                 label: Text('Book Ambulance'),
  //                                 style: ButtonStyle(
  //                                     foregroundColor: MaterialStateProperty.all(Colors.white),
  //                                     backgroundColor: MaterialStateProperty.all(Colors.red)
  //                                 ),
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
  //                               child: TextButton.icon(
  //                                 onPressed: () {
  //                                   // Contact Us -> Maybe call 108 or company
  //                                   Fluttertoast.showToast(
  //                                       msg: "Calling 108",
  //                                       toastLength: Toast.LENGTH_SHORT,
  //                                       gravity: ToastGravity.CENTER,
  //                                       backgroundColor: Colors.white,
  //                                       textColor: Colors.green,
  //                                       fontSize: 16.0
  //                                   );
  //                                 },
  //                                 icon: Icon(Icons.contact_phone_outlined),
  //                                 label: Text('Contact Us'),
  //                                 style: ButtonStyle(
  //                                     foregroundColor: MaterialStateProperty.all(Colors.white),
  //                                     backgroundColor: MaterialStateProperty.all(Colors.redAccent)
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //
  //                       ],
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 35.0,right: 35.0,top: 15.0),
  //                       child: Row(
  //                         children: [
  //                           Text("Don't know about us yet?",style: TextStyle(
  //                             fontWeight: FontWeight.w700,
  //                             fontStyle: FontStyle.italic,
  //                             color: Colors.white,
  //                             fontSize: 20,
  //                           ),
  //                           ),
  //                           TextButton(
  //                             onPressed: () async {
  //                               // Can give link to a webpage about amaxi
  //                               final url='http://twitter.com';
  //
  //                               if (await canLaunchUrl(Uri.parse(url))){
  //                                 await launch(url);
  //                               }
  //                             },
  //                             child: Text('Click here',style: TextStyle(
  //                                 fontStyle: FontStyle.italic,
  //                                 fontWeight: FontWeight.w400,
  //                                 color: Colors.blueGrey,
  //                                 fontSize: 18,
  //                                 decoration: TextDecoration.underline
  //                             )),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     TextButton(
  //                       onPressed: () async {
  //                         // give a link to utter shit
  //                         final url='http://twitter.com';
  //
  //                         if (await canLaunchUrl(Uri.parse(url))){
  //                         await launch(url);
  //                         }
  //                       },
  //                       child: Text('Privacy Policy',style: TextStyle(
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w400,
  //                           decoration: TextDecoration.underline,
  //                           color: Colors.blueGrey
  //                       ),
  //                       ),
  //                     ),
  //                     TextButton(
  //                       onPressed: () async {
  //                         // give alink to utter bullshit
  //                         final url='http://twitter.com';
  //
  //                         if (await canLaunchUrl(Uri.parse(url))){
  //                         await launch(url);
  //                         }
  //                       },
  //                       child: Text('Terma and Conditions',style: TextStyle(
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.w400,
  //                           decoration:TextDecoration.underline,
  //                           color: Colors.blueGrey
  //                       ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
