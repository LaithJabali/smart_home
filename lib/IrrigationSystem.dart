import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_switch/flutter_switch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Irrigation());
}

class Irrigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Irrigation> {
  String st = 'Automatic';
  List<String> state = ['Automatic', 'Custom'];
  bool sw = false;
  int s = 0;
  double wet = 0;
  List<bool> isSelected = [true, false];
  bool auto = false;
  bool p = false;

  checkWetness() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('WetnessLevel');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        wet = event.snapshot.value.hashCode.toDouble();
      });
      if (wet < 70) {
        p = true;
      } else {
        p = false;
      }
      print('$wet');
    });
  }

  editData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "SoilPumpState": sw,
    });
  }

  checkSoilPump() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('SoilPumpState');
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

  checkMode() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('SoilMode');
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
    });
  }

  editMode() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "SoilMode": st,
    });
  }

  @override
  void initState() {
    checkSoilPump();
    checkWetness();
    checkMode();
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
              'Irrigation System',
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
            // mainAxisAlignment: MainAxisAlignment.center,
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
              auto
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'soil pump : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        FlutterSwitch(
                          activeColor: Colors.green,
                          inactiveColor: Colors.red,
                          width: 125.0,
                          height: 45.0,
                          valueFontSize: 24.0,
                          toggleSize: 30.0,
                          value: sw,
                          borderRadius: 25.0,
                          padding: 8.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              sw = val;
                              editData();
                            });
                            print('the switch state is $sw');
                          },
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 50,
                    ),
              const SizedBox(
                height: 30,
              ),
              !auto
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Pump State : ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        !p
                            ? const Card(
                                color: Colors.green,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Pump disable , soil is wet ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : const Card(
                                color: Colors.green,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Pump enable , soil is dry ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )
                  : const SizedBox(
                      height: 50,
                    ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Wetness Level : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$wet',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          )),
    );
  }
}
