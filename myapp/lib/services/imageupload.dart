import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/services/server.dart';

Future<void> uploadImage(File uploadimage,BuildContext context,Map details) async {
    List<int> imageBytes = uploadimage.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);
    Map body = {'image':baseimage,'class': details['class']};
    http.Response response = await  Server.post('imageupload', body);
    Map returner  = jsonDecode(response.body);
    Navigator.popAndPushNamed(context,'/attendancelist',arguments:{'details' : returner} );
}
