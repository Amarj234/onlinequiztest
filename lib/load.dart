import 'dart:async';
import 'package:dranchalsclass/admindashbord.dart';

import 'package:dranchalsclass/dashboard.dart';
import 'package:dranchalsclass/homepage.dart';
import 'package:dranchalsclass/mymdal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class loadPage extends StatefulWidget {
  const loadPage({Key? key}) : super(key: key);

  @override
  State<loadPage> createState() => _loadPageState();
}

class _loadPageState extends State<loadPage> {


  checksesiion() async{

    SharedPreferences prefs =await SharedPreferences.getInstance();
    print(prefs.getString('check'));
    if(prefs.getString('check')=='2'){

      Navigator.push(
        context,MaterialPageRoute(builder: (context)=> admindash()),
      );
    }else if(prefs.getString('check')=='1'){
      Navigator.push(
        context,MaterialPageRoute(builder: (context)=> dashbord()),
      );
    }else{
      Navigator.push(
        context,MaterialPageRoute(builder: (context)=> homePage()),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () => checksesiion());
    disableCapture();
  }
  Future<void> disableCapture() async {
    //disable screenshots and record screen in current screen
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/doctor.jpg"),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}
