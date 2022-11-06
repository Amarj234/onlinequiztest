import 'dart:io';


import 'package:dranchalsclass/adddrower.dart';
import 'package:dranchalsclass/addvideo.dart';
import 'package:dranchalsclass/addvimovideo.dart';
import 'package:dranchalsclass/allvideo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'addcorce.dart';
import 'addpaidvideo.dart';
import 'allpaidvideo.dart';
import 'bankquestion.dart';
import 'qbank.dart';

class admindash extends StatefulWidget {
  const admindash({Key? key}) : super(key: key);

  @override
  State<admindash> createState() => _admindashState();
}

class _admindashState extends State<admindash> {

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      SystemNavigator.pop();
      exit(0);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),

      ),
      drawer: Adddroewr(),
      body: WillPopScope(
        onWillPop: onWillPop ,
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFFFFFFF),
          child: SafeArea(

            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                Image.asset("assets/logo.jpg",width: 300,),
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                Expanded(
                  child: GridView.count(
    primary: false,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 3,
    children:[

      InkWell(
        onTap: (){
          Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => addcourse()),
          );

        },
        child: Container(
          decoration: BoxDecoration(
                  color: Color(0xFFFEFEFE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
          ),
          height:  MediaQuery.of(context).size.height/5,
          width:   MediaQuery.of(context).size.width/2.2,
          child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/7.png",width: 60,height:60,),

                      Text('Add course',style: TextStyle(fontSize: 15,color: Colors.black),),

                    ],

                  ),
          ),

        ),
      ),

      InkWell(
        onTap: (){
          Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => Addvideo()),
          );

        },
        child: Container(
          decoration: BoxDecoration(
                  color: Color(0xFFFEFEFE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
          ),
          height:  MediaQuery.of(context).size.height/5,
          width:   MediaQuery.of(context).size.width/2.2,
          child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/8.png",width: 60,height:60,),

                      Text('Add Video',style: TextStyle(fontSize: 15,color: Colors.black),),

                    ],

                  ),
          ),

        ),
      ),



      InkWell(
        onTap: (){
          Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => allvideo()),
          );

        },
        child: Container(
          decoration: BoxDecoration(
                  color: Color(0xFFFEFEFE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
          ),
          height:  MediaQuery.of(context).size.height/5,
          width:   MediaQuery.of(context).size.width/2.2,
          child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/9.png",width: 60,height:60,),

                      Text('All Video',style: TextStyle(fontSize: 15,color: Colors.black),),

                    ],

                  ),
          ),

        ),
      ),


      InkWell(
        onTap: (){
          Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => addvimon()),
          );

        },
        child: Container(
          decoration: BoxDecoration(
                  color: Color(0xFFFEFEFE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
          ),
          height:  MediaQuery.of(context).size.height/5,
          width:   MediaQuery.of(context).size.width/2.2,
          child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/10.png",width: 60,height:60,),

                      Text('Add Vimeo',style: TextStyle(fontSize: 15,color: Colors.black),),

                    ],

                  ),
          ),

        ),
      ),


      InkWell(
        onTap: (){
          Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => addpaidvideo()),
          );

        },
        child: Container(
          decoration: BoxDecoration(
                  color: Color(0xFFFEFEFE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
          ),
          height:  MediaQuery.of(context).size.height/5,
          width:   MediaQuery.of(context).size.width/2.2,
          child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/11.png",width: 60,height:60,),

                      Text('Paid video',style: TextStyle(fontSize: 15,color: Colors.black),),

                    ],

                  ),
          ),

        ),
      ),


      InkWell(
        onTap: (){
          Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => allpaidvideo()),
          );

        },
        child: Container(
          decoration: BoxDecoration(
                  color: Color(0xFFFEFEFE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
          ),
          height:  MediaQuery.of(context).size.height/5,
          width:   MediaQuery.of(context).size.width/2.2,
          child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset("assets/12.png",width: 60,height:60,),

                      Text('Paid View',style: TextStyle(fontSize: 15,color: Colors.black),),

                    ],

                  ),
          ),

        ),
      ),





      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
