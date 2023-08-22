import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/services/server.dart';

void fetchStudents(Map classdetails,BuildContext context) async{
  Map body = {'class' : classdetails['class'] };
  String endPoint = 'studentdetails';
  http.Response response = await Server.post(endPoint, body);
  Map res = jsonDecode(response.body);
  Navigator.popAndPushNamed(context, '/attendancelist',arguments: {'details':res});
}