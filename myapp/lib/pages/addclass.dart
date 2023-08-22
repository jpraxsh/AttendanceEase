import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/addclass.dart';
import 'dart:io';
class Droplist{
  List<String> list = <String>[];
  late String val;
  void addVal(Map map){
    for(int i=0;i<map.length;i++)
      list.add(map[i.toString()]);
    val = list.first;
  }
}
class DropButton extends StatefulWidget {
  final Droplist droplist;
  const DropButton({required this.droplist,Key? key}) : super(key: key);

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: widget.droplist.val,
        items: widget.droplist.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            widget.droplist.val = value!;
          });
        }
    );

  }
}

class Addclass extends StatefulWidget {
  final Map details;
  const Addclass({required this.details ,Key? key}) : super(key: key);

  @override
  State<Addclass> createState() => _AddclassState();
}

class _AddclassState extends State<Addclass> {
  Map send_details={};
  late String subcode;
  late String subtitle;
  late String batch;
  Droplist years = new Droplist();
  Droplist depts = new Droplist();
  Map details = {};
  late File excelfile;
  String filename='Pick a file';
  @override
  void initState() {
    details = widget.details;
    years.addVal(details['years']) ;
    depts.addVal(details['depts']) ;
    subcode='';
    subtitle = '';



    String batch = '';

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: addclasspage(),
          bottomNavigationBar: Container(
              height:50.0,
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  send_details['year']=years.val;
                  send_details['dept']=depts.val;
                  send_details['subcode']=subcode;
                  send_details['filename']=filename;
                  createClass(send_details,excelfile);
                },

              )
          )

      ),
    );
  }
  Widget addclasspage() {
    return Column(
      children: [
        Row(
          children: [
            Text('Year '),
            DropButton(droplist: years,),

          ],
        ),
        Row(
          children: [
            Text('Department '),
            DropButton(droplist: depts),
          ],
        ),
        Row(
          children: [
            Text('Subcode:'),
            Expanded(
              child: TextField(
                onChanged:(String val) async {
                  String newsubtitle = await  getSubtitle(val);
                  setState((){
                    subcode = val;
                    subtitle = newsubtitle;
                  });
                }
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text('Sub Title :'),
            Expanded(child:
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: subtitle,
              ),
            ),
            )


          ],
        ),
        Row(
          children: [
            Text('File'),
            TextButton(
                onPressed:() async {
                  try{
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type:FileType.any
                    );
                    if (result?.files.first != null){
                      PlatformFile pf = result!.files.first;
                      File file = File(pf!.path.toString());

                      String?  fileName = result?.files.first.name;
                      setState(() {
                        excelfile = file;
                        filename = fileName!;
                      });


                  }}
                  catch(e){
                    print(e);
                  }


                },
                child: Text(filename))
          ],
        )
      ],
    );
  }
}


