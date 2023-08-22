// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/services/imageupload.dart';
class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  Map details = {};
  var img;

  final imagePicker = ImagePicker();
  Future getImage() async{
    var image = await imagePicker.pickImage(source: ImageSource.camera);
    setState((){
       img = File(image!.path);
    }
    );
  }
  @override
  initState(){
    getImage();
  }
  @override
  Widget build(BuildContext context) {
    details = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      body: SafeArea(
        child: img == null ? Text('NO image') : Image.file(img),

      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.camera_alt),
        onPressed: ()=>getImage(),
      ),
      bottomNavigationBar:img ==null ?null: Container(
          height:50.0,
          child: ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                uploadImage(img,context,details);
              },

          )
      ),
    );
  }

}
