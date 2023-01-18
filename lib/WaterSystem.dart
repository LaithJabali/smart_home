// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_print, non_constant_identifier_names, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:rolling_switch/rolling_switch.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:weekday_selector/weekday_selector.dart';

void main() {
  runApp(Water());
}

class Water extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<Water> {
  late DateTime newDateTime = DateTime(11, 33);
  late DateTime EndDateTime = DateTime(11, 34);
  int hh = 0, mm = 0;
  int Ehh = 0, Emm = 0;
  int hours = 0;
  int minutes = 0;
  List<bool> values = [false, false, false, false, false, false, false];
  List<bool>? aa = [false, true, false, false, true, false, false];
  late DateTime datet = DateTime(0, 0, 0, 0, 0);

  editTime() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "Hour": hh,
      "Minute": mm,
    });
  }

  editEndTime() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "EndHour": Ehh,
      "EndMinute": Emm,
    });
  }

  editDay() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.update({
      "Days": values,
    });
  }

  checkHour() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Hour');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        hours = event.snapshot.value.hashCode.toInt();
      });
    });
  }

  checkDays() {}

  checkMinute() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Minute');
    starCountRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        minutes = event.snapshot.value.hashCode.toInt();
      });
    });
  }

  @override
  void initState() {
    checkHour();
    checkMinute();
    checkDays();

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
              'Scheduling System',
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
          body: Center(
            child: Column(children: [
              SizedBox(
                height: 100,
              ),
              Container(
                  height: 60,
                  width: 370,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70),
                  child: WeekdaySelector(
                    selectedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    shortWeekdays: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
                    disabledColor: Colors.green,
                    selectedColor: Colors.black,
                    selectedFillColor: Colors.green,
                    onChanged: (int v) {
                      setState(() {
                        values[v % 7] = !values[v % 7];
                        print(values);
                      });
                    },
                    values: values,
                  )),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text('   From : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 8, 8, 8),
                      )),
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: datet,
                      onDateTimeChanged: (DateTime neswDateTime) {
                        //Do Some thing
                        setState(() {
                          newDateTime = neswDateTime;
                        });
                      },
                      use24hFormat: false,
                      minuteInterval: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text('   To :      ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 8, 8, 8),
                      )),
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime(hours, minutes),
                      onDateTimeChanged: (DateTime neswDateTime) {
                        //Do Some thing
                        setState(() {
                          EndDateTime = neswDateTime;
                        });
                      },
                      use24hFormat: false,
                      minuteInterval: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: StadiumBorder(),
                    fixedSize: Size(200, 50),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  onPressed: () {
                    //gate = 'Open';

                    setState(() {
                      hh = newDateTime.hour;
                      mm = newDateTime.minute;
                      Ehh = EndDateTime.hour;
                      Emm = EndDateTime.minute;

                      editTime();
                      editEndTime();
                      editDay();
                    });

                    print(hh);
                  }),
            ]),
          )
          // child: Image(image: AssetImage('imgs/os.png')),
          ),
    );
  }
}
