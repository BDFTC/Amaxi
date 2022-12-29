import 'package:flutter/material.dart';

class driverDashboard extends StatefulWidget {
  const driverDashboard({Key? key}) : super(key: key);

  @override
  State<driverDashboard> createState() => _driverDashboardState();
}

class _driverDashboardState extends State<driverDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('amaxi')),
        body: TextButton(onPressed:() {}, child: Text('Ready to go'))
    );
  }
}
