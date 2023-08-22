import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/services/server.dart';
import 'dart:convert';

Future<Map> fetchClass(String uname) async{
  String endPoint = 'viewclass';
  Map body = {'uname':uname};
  http.Response res  = await Server.post(endPoint,body );
  Map response = jsonDecode(res.body);
  return response;

}