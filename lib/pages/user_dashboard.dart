import 'package:flutter/material.dart';

class userDashboard extends StatefulWidget {
  const userDashboard({Key? key}) : super(key: key);

  @override
  State<userDashboard> createState() => _userDashboardState();
}

class _userDashboardState extends State<userDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('amaxi')),
      body: TextButton(onPressed:() {}, child: Text('Book Ambulance'))
    );
  }
}
