import 'package:flutter/material.dart';
import 'package:myapp/services/takeattendance.dart';

class Attendancelist extends StatefulWidget {
  const Attendancelist({Key? key}) : super(key: key);

  @override
  State<Attendancelist> createState() => _AttendancelistState();
}

class _AttendancelistState extends State<Attendancelist> {
  Map details = {};
  @override
  Widget build(BuildContext context) {
    details = ModalRoute.of(context)!.settings.arguments as Map;
    details = details['details'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[500],
        appBar: AppBar(
          title: Text('students'),
        ),
          body: generateStudentList(),
        bottomNavigationBar: Container(
            height:50.0,
            child: ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                takeAttendance(details,context);
              },

            )
        ),
    ));
  }
  Widget generateStudentList(){
    return RawScrollbar(
      thickness: 6,
      thumbColor: Colors.white,
      child: ListView.builder(
        itemCount: details.length,
        itemBuilder: (BuildContext context, int index) {
         Map student = details['$index'];
         bool present = student['present']=='1';
          return Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            height: 50,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Card(
              color: present ?Colors.green:Colors.white,
              elevation: 2,
              child: ListTile(

                  title: Container(
                    padding: EdgeInsets.zero,
                    child: Text('${student['regno']}    ${student['name']}'),
                  ),
                  onTap: (){
                    setState((){
                      details['$index']['present']=details['$index']['present']=='1'?'0':'1';
                    });

                  }

              ),
            ),
          );
        },

      ),
    );
  }
  }


