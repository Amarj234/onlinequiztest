import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dranchalsclass/Singlevideo.dart';
import 'package:dranchalsclass/sarvice.dart';
import 'package:dranchalsclass/vimoplayer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class videoplay extends StatefulWidget {
  const videoplay({Key? key}) : super(key: key);

  @override
  State<videoplay> createState() => _videoplayState();
}

class _videoplayState extends State<videoplay> {

  List<ListTile> allvideo=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allcourse();

  }
  Serves serves=Serves();
  Future allcourse() async {


    final uri = Uri.parse(serves.url+"getvideo.php");
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var regid =prefs.getString('regid');

    var response = await http.post(uri,body: {
      'showdata':regid.toString(),

    });
    allvideo=[];
    var state= json.decode(response.body);
    setState(() {
      state.forEach((item)async {
        final List<int> codeUnits = item['videothumble'].codeUnits;
        final Uint8List unit8List = Uint8List.fromList(codeUnits);
        if (item['showhide'] == '1') {
          allvideo.add(
            ListTile(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => Singlevideo(id: item['videopath'])),
                );
              },
              title: Text(item['video_titel'].toString(), style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                  fontFamily: 'RobotoMono'
              ),),
              subtitle: Text(item['discription'].toString(), style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w200,
                  fontSize: 15
              ),),
              leading: Image.asset('assets/logo.jpg', height: 200,width: 100,),

            ),


          );
        }else{
          allvideo.add(
            ListTile(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => MyHomePage1(id: item['videopath'],name:item['video_titel'],dis:item['discription'] )),
                );
              },
              title: Text(item['video_titel'].toString(), style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 25,
                  fontFamily: 'RobotoMono'
              ),),
              subtitle: Text(item['discription'].toString(), style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w200,
                  fontSize: 15
              ),),
              leading: Image.network(serves.url+item['videothumble'], height: 200,width: 100),

            ),


          );


        }
      }
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your course videos'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: allvideo,
          ),
        ),
      ),
    );
  }
}
