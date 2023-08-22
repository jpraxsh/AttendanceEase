// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/services/addclass.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};
  Map classdetails={};
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    classdetails = data['class'];
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Row(
          children: [
            Text("Class"),
            Container(
              margin: EdgeInsetsDirectional.fromSTEB(90, 0, 0, 0),
              child: Text(data['uname'],
              textAlign: TextAlign.end,),
            ),
          ],
        )

      ),
      body:renderClass(classdetails),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            toAddclass(context);
          }
      ),
    );
  }
  void moveAttendance(Map detail ){
    Navigator.pushNamed(context,'/calender');
    // Navigator.pushNamed(context, '/attendance',arguments: detail);
  }
  ListView renderClass(Map classdetails){
    return ListView.builder(
      itemCount: classdetails.length,
      itemBuilder: (BuildContext context, int index) {

        int i=index+1;
        Map detail = classdetails['$i'];
        return Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
          padding: EdgeInsets.all(2),
          height: 120,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Card(
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.only(left:10),
              hoverColor: Colors.pink,
              title: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Row(
                  children: [
                    Column(
                      children:  [
                        Text(detail['class']),
                        SizedBox(height: 20,),
                        Text('Strength : ${detail['strength']}')
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left:100,right:0),
                      child: Column(
                        children: [
                          Text(detail['course']),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              onTap: ()=> moveAttendance(detail)

            ),
          ),
        );
      },

    );
  }
}
