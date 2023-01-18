// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Monitoring());
}

class Monitoring extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Monitoring> {
  bool sw = true;
  int s = 0;
  String url = "";
  String url2 = "";

  _launchUrl() async {
    await launch('http://$url', forceSafariVC: true);
  }

  _launchUrl2() async {
    await launch('http://$url2', forceSafariVC: true);
  }

  checkIP() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Camera');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        url = event.snapshot.value.toString();
      });
    });
  }

  checkIP2() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Camera2');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        url2 = event.snapshot.value.toString();
      });
    });
  }

  checkMonitoring() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('MonitoringState');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        s = event.snapshot.value.hashCode;
        //1237 equal to fasle and 1231 equal to true
      });
      if (s == 1237) {
        sw = false;
      } else {
        sw = true;
      }
      print('$sw');
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "MonitoringState": sw,
    });
  }

  @override
  void initState() {
    checkMonitoring();
    checkIP();
    checkIP2();

    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 189, 58, 58),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 42, 61, 53),
            title: const Text(
              'Monitoring System',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body:
              // child: Image(image: AssetImage('imgs/os.png')),
              Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Outside :  ',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: const StadiumBorder(),
                      fixedSize: const Size(200, 50),
                    ),
                    onPressed: _launchUrl,
                    child: const Text(
                      'Start Monitoring',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Inside :     ',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: const StadiumBorder(),
                      fixedSize: const Size(200, 50),
                    ),
                    onPressed: _launchUrl2,
                    child: const Text(
                      'Start Monitoring',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
