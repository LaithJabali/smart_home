// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(InLight());
}

class InLight extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<InLight> {
  String st = 'Automatic';
  List<String> state = ['Automatic', 'Custom'];
  double oli = 0.0;
  double ili = 0.0;
  int l = 0;
  int ll = 0;
  List<bool> isSelected = [true, false];
  bool auto = false;
  bool led1 = false;
  bool led2 = false;
  bool led3 = false;
  bool led4 = false;
  bool sw = true;

  checkOutIntensity() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('OutLightIntensity');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        oli = event.snapshot.value.hashCode.toDouble();
      });
      print('$oli');
    });
  }

  checkInIntensity() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('InLightIntensity');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        ili = event.snapshot.value.hashCode.toDouble();
      });
      if (st == "Automatic") {
        if (ili >= 0 && ili <= 20) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = true;
        } else if (ili > 20 && ili <= 40) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = false;
        } else if (ili > 40 && ili <= 60) {
          led1 = true;
          led2 = true;
          led3 = false;
          led4 = false;
        } else if (ili > 60 && ili <= 80) {
          led1 = true;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (ili > 80 && ili <= 100) {
          led1 = false;
          led2 = false;
          led3 = false;
          led4 = false;
        }
      } else if (st == "Custom") {
        if (l == 0) {
          led1 = false;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (l > 0 && l <= 20) {
          led1 = true;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (l > 20 && l <= 50) {
          led1 = true;
          led2 = true;
          led3 = false;
          led4 = false;
        } else if (l > 50 && l <= 80) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = false;
        } else if (l > 80 && l <= 100) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = true;
        }
      }
      print('$ili');
    });
  }

  checkData() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('InLambValue');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        l = event.snapshot.value.hashCode;
      });
      if (st == "Automatic") {
        if (ili >= 0 && ili <= 20) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = true;
        } else if (ili > 20 && ili <= 40) {
          led1 = true;
          led2 = true;
          led3 = true;
          led4 = false;
        } else if (ili > 40 && ili <= 60) {
          led1 = true;
          led2 = true;
          led3 = false;
          led4 = false;
        } else if (ili > 60 && ili <= 80) {
          led1 = true;
          led2 = false;
          led3 = false;
          led4 = false;
        } else if (ili > 80 && ili <= 100) {
          led1 = false;
          led2 = false;
          led3 = false;
          led4 = false;
        }
      } else if (st == "Custom") {
        if (l == 0) {
          led1 = false;
        } else
          led1 = true;
      }
      print('$l');
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "InLambValue": l,
    });
  }

  checkMode() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('InOperationMode');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        st = event.snapshot.value.toString();
      });
      if (st == 'Automatic') {
        auto = false;
      } else if (st == 'Custom') {
        auto = true;
      }
      print('$st');
      print(auto);
    });
  }

  editMode() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "InOperationMode": st,
    });
    if (st == 'Automatic') {
      auto = false;
    } else if (st == 'Custom') {
      auto = true;
    }
    if (st == "Automatic") {
      if (ili >= 0 && ili <= 20) {
        led1 = true;
        led2 = true;
        led3 = true;
        led4 = true;
      } else if (ili > 20 && ili <= 40) {
        led1 = true;
        led2 = true;
        led3 = true;
        led4 = false;
      } else if (ili > 40 && ili <= 60) {
        led1 = true;
        led2 = true;
        led3 = false;
        led4 = false;
      } else if (ili > 60 && ili <= 80) {
        led1 = true;
        led2 = false;
        led3 = false;
        led4 = false;
      } else if (ili > 80 && ili <= 100) {
        led1 = false;
        led2 = false;
        led3 = false;
        led4 = false;
      }
    } else if (st == "Custom") {
      if (l == 0) {
        led1 = false;
        led2 = false;
        led3 = false;
        led4 = false;
      } else if (l > 0 && l <= 20) {
        led1 = true;
        led2 = false;
        led3 = false;
        led4 = false;
      } else if (l > 20 && l <= 50) {
        led1 = true;
        led2 = true;
        led3 = false;
        led4 = false;
      } else if (l > 50 && l <= 80) {
        led1 = true;
        led2 = true;
        led3 = true;
        led4 = false;
      } else if (l > 80 && l <= 100) {
        led1 = true;
        led2 = true;
        led3 = true;
        led4 = true;
      }
    }
    print(auto);
  }

  @override
  void initState() {
    checkData();
    checkInIntensity();
    checkMode();
    checkOutIntensity();
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
              'Inside Light System',
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
              ListView(
            children: [
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: isSelected,
                    selectedColor: Colors.white,
                    color: Colors.white,
                    // fill color of selected toggle
                    fillColor: Colors.green,
                    splashColor: Colors.green,
                    // long press to identify highlight color
                    highlightColor: Colors.orange,
                    // if consistency is needed for all text style
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    // border properties for each toggle
                    renderBorder: true,
                    borderColor: Colors.black,
                    borderWidth: 1.5,
                    borderRadius: BorderRadius.circular(10),
                    selectedBorderColor: Colors.black,
// add widgets for which the users need to toggle
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child:
                            Text('Automatic', style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text('Manual', style: TextStyle(fontSize: 18)),
                      ),
                    ],
// to select or deselect when pressed
                    onPressed: (index) {
                      setState(() {
                        isSelected[0] = !isSelected[0];
                        isSelected[1] = !isSelected[1];
                        st = state[index.hashCode];
                        editMode();
                      });
                      print('$st');
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Indoor Light Intensity : ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Card(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$ili',
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // ElevatedButton(
                  //     child: const Text('click me'),
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     })
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Lamp State : ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 5, 5, 5)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  led1
                      ? (Text(
                          'ON',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 5, 5, 5)),
                        ))
                      : (Text(
                          'OFF',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 5, 5, 5)),
                        )),

                  // ElevatedButton(
                  //     child: const Text('click me'),
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     })
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              auto
                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const SizedBox(
                        width: 20,
                      ),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterSwitch(
                              activeColor: Colors.green,
                              inactiveColor: Colors.red,
                              width: 135.0,
                              height: 45.0,
                              valueFontSize: 24.0,
                              toggleSize: 30.0,
                              value: sw,
                              borderRadius: 25.0,
                              padding: 8.0,
                              showOnOff: true,
                              onToggle: (val) {
                                setState(() {
                                  if (sw == true) {
                                    l = 1;
                                  } else
                                    l = 0;
                                  sw = val;
                                  editData();
                                });
                                print('the switch state is $sw');
                              },
                            ),
                          ]),
                      // Expanded(
                      //   child: Slider(
                      //     inactiveColor: Color.fromARGB(255, 8, 8, 8),
                      //     thumbColor: Colors.yellow,
                      //     value: ll.toDouble(),
                      //     max: 100,
                      //     divisions: 100,
                      //     label: ll.round().toString(),
                      //     onChanged: (double value) {
                      //       setState(() {
                      //         editData();
                      //         l = ll;
                      //         ll = value.toInt();
                      //       });
                      //     },
                      //   ),
                      // ),

                      const SizedBox(
                        width: 10,
                      ),
                    ])
                  : Card(),
              const SizedBox(
                height: 50,
              ),
            ],
          )),
    );
  }
}
