import 'package:url_launcher/url_launcher.dart';

class MapUtils{
  MapUtils._();
  static Future<void> openMap(double user_latitude, double user_longitude, double hospital_latitude, double hospital_longitude) async{
    // String googleMapUrl="https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    String googleMapUrl="https://www.google.com/maps/dir/$hospital_latitude,$hospital_longitude/$user_latitude,$user_longitude";
    if(await canLaunchUrl(Uri.parse(googleMapUrl))){
      await launchUrl(Uri.parse(googleMapUrl));
    } else {
      throw 'Could not open the map';
    }
  }
}