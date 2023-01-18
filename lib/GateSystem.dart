// ignore_for_file: unnecessary_string_interpolations, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Gate());
}

class Gate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Gate> {
  String state = 'Opened';
  List<bool> isSelected = [true, false];
  bool opened = false;
  String gate = 'open';
  String st = 'Automatic';
  List<String> mode = ['Automatic', 'Custom'];
  bool auto = false;
  bool motion = false;
  int s = 0;
  String dist = "";
  double dd = 0;
  String url = "";

  // checkMotion() async {
  //   DatabaseReference starCountRef =
  //       FirebaseDatabase.instance.ref('GateMotion');
  //   starCountRef.onValue.listen((DatabaseEvent event) {
  //     setState(() {
  //       s = event.snapshot.value.hashCode;
  //       //1237 equal to fasle and 1231 equal to true
  //     });
  //     if (s == 1237) {
  //       motion = false;
  //     } else {
  //       motion = true;
  //     }
  //     print('$motion');
  //   });
  // }

  getDs() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('DistanceCm');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        dist = event.snapshot.value.toString();
      });
      dd = double.parse(dist);

      if (dd <= 22) {
        motion = true;
      } else {
        motion = false;
      }
    });
  }

  checkMode() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('GateMode');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        st = 'Custom';
      });
      if (st == 'Automatic') {
        auto = false;
      } else if (st == 'Custom') {
        auto = true;
      }
      print('$st');
    });
  }

  editMode() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "GateMode": st,
    });
  }

  checkGate() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('GateState');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        state = event.snapshot.value.toString();
        if (state == 'Opened') {
          opened = true;
        } else if (state == 'Closed') {
          opened = false;
        }
      });
      print('$state');
    });
  }

  editGate() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "Gate": gate,
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "GateState": state,
    });
  }

  _launchUrl() async {
    await launch('http://$url', forceSafariVC: true);
  }

  checkIP() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Camera');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        url = event.snapshot.value.toString();
      });
    });
  }

  sendPushNotify(
    String body,
  ) async {
    String? myT = await FirebaseMessaging.instance.getToken();
    print(myT);
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'AAAAvGluEEk:APA91bHSqQRDyITF2CuAtHLL2cxMqZdS-QLLtX_85rOsdeBzGwd4Q7ZliQtpxLk7GTzfRx7g5PFv_B5pJta2d_nkR1pRzsjp1DPvD3UOqqRJU0qzKUry-5cNHTZSsd3BDyMJSV9CyJGS',
        },
        body: jsonEncode(<String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': 'SmartHome'
          },
          'priorty': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          },
          'to':
              'fWJ8rj8GS_uvrH-sqt3k0d:APA91bHGPBfxihKYHDLgEXEqYDY97q0bNBh8VzoNf_tSHTeNFqvDIrknmjB7_ThIo-DC55xgAXOMQcgnC0Vx4ZhLjnoUYLP54T5pXLG4lKPLsJHeCveUfXmwA99PjcHE3u4TEZNVV2Wt'
        }));
  }

  @override
  void initState() {
    checkGate();
    checkMode();
    checkIP();

    //checkMotion();

    getDs();
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
            'Gate System',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
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
            ListView(
          children: [
            const SizedBox(
              height: 150,
            ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ToggleButtons(
//                   isSelected: isSelected,
//                   selectedColor: Colors.white,
//                   color: Colors.white,
//                   // fill color of selected toggle
//                   fillColor: Colors.green,
//                   splashColor: Colors.green,
//                   // long press to identify highlight color
//                   highlightColor: Colors.orange,
//                   // if consistency is needed for all text style
//                   textStyle: const TextStyle(fontWeight: FontWeight.bold),
//                   // border properties for each toggle
//                   renderBorder: true,
//                   borderColor: Colors.black,
//                   borderWidth: 1.5,
//                   borderRadius: BorderRadius.circular(10),
//                   selectedBorderColor: Colors.black,
// // add widgets for which the users need to toggle
//                   children: const [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 32),
//                       child: Text('Automatic', style: TextStyle(fontSize: 18)),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 32),
//                       child: Text('Manual', style: TextStyle(fontSize: 18)),
//                     ),
//                   ],
// // to select or deselect when pressed
//                   onPressed: (index) {
//                     setState(() {
//                       isSelected[0] = !isSelected[0];
//                       isSelected[1] = !isSelected[1];
//                       st = mode[index.hashCode];
//                       editMode();
//                     });
//                     print('$st');
//                   },
//                 ),
//               ],
//             ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('           Gate State : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 8, 8, 8),
                    )),
                opened
                    ? Card(
                        color: Colors.green,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Opend',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 7, 7, 7),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.door_sliding_outlined,
                              color: Color.fromARGB(255, 51, 51, 47),
                              size: 30,
                            ),
                          ],
                        ),
                      )
                    : Card(
                        color: Colors.green,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Closed',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.door_sliding,
                              color: Color.fromARGB(255, 51, 51, 47),
                              size: 30,
                            ),
                          ],
                        ),
                      )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                motion
                    ? Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.yellow,
                                size: 50,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Someone Close',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.yellow,
                                size: 50,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: const StadiumBorder(),
                              fixedSize: const Size(160, 40),
                            ),
                            onPressed: _launchUrl,
                            child: const Text(
                              'Watch The Camera',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: const [
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Nothing Close',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 3, 3, 3)),
                          ),
                        ],
                      ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            auto
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: StadiumBorder(),
                            fixedSize: Size(100, 50),
                          ),
                          child: const Text(
                            'Open',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          onPressed: () async {
                            gate = 'Open';
                            setState(() {
                              editGate();
                            });
                            await sendPushNotify("hla fekm ar7bo");
                            print(gate);
                          }),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: StadiumBorder(),
                            fixedSize: Size(100, 50),
                          ),
                          child: const Text('Close',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                          onPressed: () {
                            gate = 'Close';
                            setState(() {
                              editGate();
                            });
                            print(gate);
                          }),
                    ],
                  )
                : const SizedBox(
                    height: 50,
                  ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
