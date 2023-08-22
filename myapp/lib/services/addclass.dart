import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myapp/pages/addclass.dart';
import 'package:myapp/services/server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
void toAddclass(BuildContext context) async {
  http.Response  response = await  Server.post('/fetchclassdetails',{});
  Map res = jsonDecode(response.body);
  Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=> Addclass(details: res)));

}
Future<String> getSubtitle(String subcode) async{
  http.Response response = await Server.post('getsubtitle', {'subcode':subcode});
  Map res = jsonDecode(response.body);
  return res['subtitle'];
}
Future<void> createClass(Map details,File excelfile) async {
  List<int> filebytes = excelfile.readAsBytesSync();
  String basefile = base64Encode(filebytes);
  details['file']=basefile;
  http.Response response = await Server.post('createclass', details);
  Map res = jsonDecode(response.body);
  print(res);

}
void addClass() async {
  final prefs = await SharedPreferences.getInstance();
  String? uname = await prefs.getString('uname');

}