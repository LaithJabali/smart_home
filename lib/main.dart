// import 'dart:ffi';

// ignore_for_file: unused_import, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'IrrigationSystem.dart';
import 'ConditionSystem.dart';
import 'FireSystem.dart';
import 'GateSystem.dart';
import 'InLightSystem.dart';
import 'MonitoringSystem.dart';
import 'OutLightSystem.dart';
import 'WaterSystem.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyApp> {
  int s = 0;
  bool st = false;

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });

    // checkMotion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 133, 32, 32),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 42, 61, 53),
        title: const Text(
          'Smart Home Systems',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 65,
          ),

          // Container(
          //   child: Center(
          //     child: const SizedBox(
          //       width: 143,
          //       height: 50,
          //       child: Text(
          //         'Home Systems',
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255), width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            title: const Center(
                child: Text('Monitoring System',
                    style: TextStyle(
                      fontSize: 20,
                      //   fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ))),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Monitoring()));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255), width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            title: const Center(
                child: Text(
              'Gate System',
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            )),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Gate()));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255), width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            title: const Center(
              child: Text('Inside Light System',
                  style: TextStyle(
                    fontSize: 20,
                    //   fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => InLight()));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255), width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            title: const Center(
              child: Text('Outside Light System',
                  style: TextStyle(
                    fontSize: 20,
                    //   fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => OutLight()));
            },
          ),
          const SizedBox(
            height: 10,
          ),

          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 240, 240, 240), width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            title: const Center(
                child: Text('Condition System',
                    style: TextStyle(
                      fontSize: 20,
                      //   fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 251, 251),
                    ))),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Condition()));
            },
          ),
          const SizedBox(
            height: 10,
          ),

          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255), width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            title: const Center(
                child: Text('Fire System',
                    style: TextStyle(
                      fontSize: 20,
                      //  fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ))),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Fire()));
            },
          ),

          const SizedBox(
            height: 10,
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255), width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            title: const Center(
              child: Text('Irrigation System',
                  style: TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Irrigation()));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Color.fromARGB(255, 243, 243, 243), width: 1.5),
              borderRadius: BorderRadius.circular(5),
            ),
            title: const Center(
              child: Text('Scheduling System',
                  style: TextStyle(
                    fontSize: 20,
                    //  fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Water()));
            },
          ),
          // const Image(
          //   image: AssetImage('imgs/SmartHome.png'),
          //   fit: BoxFit.fill,
          // ),
          // const SizedBox(
          //   height: 60,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Text(
          //       'Welcome ',
          //       style: TextStyle(
          //           fontSize: 30,
          //           fontWeight: FontWeight.bold,
          //           color: Color.fromARGB(255, 212, 227, 9)),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // // ignore: prefer_const_constructors
          // Container(
          //   // width: 100,
          //   child: const Text(
          //     'You can see the Information about the systems from menu icon of AppBar.',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //         color: Color.fromARGB(255, 8, 212, 239)),
          //   ),
          // ),
          // const SizedBox(
          //   height: 50,
          // ),
        ],
      ),
    );
  }
}
