import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/services/server.dart';
import 'package:myapp/services/fetchclass.dart';
import 'package:shared_preferences/shared_preferences.dart';

  Future<void> loginCheck(String uname,String pass,BuildContext context) async{
    Map reqObj = {'uname':uname,'pass':pass};
    http.Response res = await Server.post('login',reqObj);
    Map response = jsonDecode(res.body);
    if(response['status']=='true'){
      Map classdetails = await fetchClass(uname);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uname', uname);
      Navigator.pushNamed(context, '/home' , arguments: {'uname':uname,'class':classdetails});
    }
    else{
      Fluttertoast.showToast(msg: "Invalid Credentials");
    }
  }

