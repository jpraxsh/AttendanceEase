import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
String url='http://192.168.226.167:2003/';
class Server {
  static Future<http.Response> post(String route,Map body) async{
    String endPoint = url+route;
    var uri = Uri.parse(endPoint);
    http.Response response = http.Response('kk',408,) ;
    try{
      print('gveb');
        response =  await http.post(
        uri,
        headers: {'Content-Type' : 'application/json; charset=UTF-8', },
        body: jsonEncode(body),
      );
    }
    catch (e){
      print('co');
    }

    return response;

  }
}
