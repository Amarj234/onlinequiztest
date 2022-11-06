import 'dart:io';
import 'package:dranchalsclass/adddrower.dart';
import 'package:dranchalsclass/sarvice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'allcorce.dart';
import 'allquiz.dart';
import 'buyquiz.dart';
import 'buyvideo.dart';

import 'model/mycorce.dart';
import 'paidvideo.dart';
class dashbord extends StatefulWidget {
  const dashbord({Key? key}) : super(key: key);

  @override
  State<dashbord> createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> {
  Serves serves=Serves();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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
    return Container(child: Scaffold(
      appBar: AppBar(
        title: Text('Dashbord'),
        //automaticallyImplyLeading: false,


      ),
      drawer: Adddroewr(),
      body: WillPopScope(
        onWillPop: onWillPop ,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              Image.asset("assets/logo.jpg",width: 300,),
SizedBox(height: MediaQuery.of(context).size.height/20,),
              Expanded(
                child: Center(
                  child:
                        GridView.count(
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
                                      builder: (context) => mycourse()),
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
                                      Image.asset("assets/1.png",width: 60,height:60,),

                                        Text('My course',style: TextStyle(fontSize: 15,color: Colors.black),),

                                      ],

                                    ),
                                  ),

                                ),
                              ),

                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => allcourse()),
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
                                        Image.asset("assets/2.png",width: 60,height:60,),

                                        Text('All course',style: TextStyle(fontSize: 15,color: Colors.black),),

                                      ],

                                    ),
                                  ),

                                ),
                              ),

                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => paidvideo()),
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
                                        Image.asset("assets/3.png",width: 60,height:60,),

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
                                      builder: (context) => buyvideo()),
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
                                        Image.asset("assets/4.png",width: 60,height:60,),

                                        Text('My video',style: TextStyle(fontSize: 15,color: Colors.black),),

                                      ],

                                    ),
                                  ),

                                ),
                              ),

                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => allquiz()),
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
                                        Image.asset("assets/5.png",width: 60,height:60,),

                                        Text('All Quiz',style: TextStyle(fontSize: 15,color: Colors.black),),

                                      ],

                                    ),
                                  ),

                                ),
                              ),

                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => buyquiz()),
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
                                        Image.asset("assets/6.png",width: 60,height:60,),

                                        Text('Our Quiz',style: TextStyle(fontSize: 15,color: Colors.black),),

                                      ],

                                    ),
                                  ),

                                ),
                              ),


                              ]
                        ),


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
