import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/services/server.dart';
import 'dart:convert';

Future<void> takeAttendance(Map details,BuildContext context) async{
  http.Response res = await Server.post('takeattendance', {'students':details});
  Map response = jsonDecode(res.body) as Map;
  Fluttertoast.showToast(msg: response['status']);
  Navigator.pop(context);
}