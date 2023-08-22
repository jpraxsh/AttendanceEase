// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/services/fetchstudents.dart';
class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  Map details={};
  @override
  Widget build(BuildContext context) {
    details = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title:Text('Choose Attendance') ,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left:100),
            iconSize: 150,
            onPressed: (){
              Navigator.popAndPushNamed(context, '/camera',arguments: details);
            }, icon:Icon(Icons.camera_alt) ,
          ),
          IconButton(
            onPressed: (){
              fetchStudents(details,context);
            }, icon:Icon(Icons.note_alt_rounded) ,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left:100),
            iconSize: 150,
          ),
        ],
      )
    );
  }
}

