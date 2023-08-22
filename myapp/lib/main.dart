// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:myapp/pages/attendance.dart';
import 'package:myapp/pages/attendancelist.dart';
import 'package:myapp/pages/calendar.dart';
import 'package:myapp/pages/login.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/attendance.dart';
import 'package:myapp/pages/camera.dart';
import 'package:myapp/pages/addclass.dart';
void main (){/**/
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //initialRoute: '/home',
    routes: {
      '/': (context) => Login(),
      '/home': (context) => Home(),
      '/attendance': (context) => Attendance(),
      '/camera': (context) => Camera(),
      '/attendancelist': (context) => Attendancelist(),
      '/calender':(context)=>Calender(),

    }
  )
  );
}




