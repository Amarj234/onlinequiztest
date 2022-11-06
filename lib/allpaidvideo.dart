import 'dart:convert';
import 'dart:typed_data';
import 'package:dranchalsclass/Singlevideo.dart';
import 'package:dranchalsclass/sarvice.dart';
import 'package:dranchalsclass/vimoplayer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class allpaidvideo extends StatefulWidget {
  const allpaidvideo({Key? key}) : super(key: key);

  @override
  State<allpaidvideo> createState() => _allpaidvideoState();
}

class _allpaidvideoState extends State<allpaidvideo> {


  List<ListTile> allpaidvideo=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allcourse();

  }
  Serves serves=Serves();
  Future allcourse() async {


    final uri = Uri.parse(serves.url+"allpaidvideo.php");
    SharedPreferences prefs =await SharedPreferences.getInstance();
    var regid =prefs.getString('regid');

    var response = await http.post(uri,body: {
      'showdata':regid.toString(),

    });
    allpaidvideo=[];
    var state= json.decode(response.body);
    print(state);
    setState(() {
      state.forEach((item)async {

print(state);
          allpaidvideo.add(
            ListTile(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => MyHomePage1(id: item['videoid'],name:item['name'],dis:item['discription'])),
                );
              },
              title: Text(item['name'].toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    fontFamily: 'RobotoMono'
                ),),
              subtitle: Text(item['discription'].toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w200,
                    fontSize: 15
                ),),
              leading: Image.network(serves.url+item['thumbnail'], height: 200,width: 100),

            ),


          );



      }
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Paid videos'),
      ),
      body: allpaidvideo.length==0? Center(child: CircularProgressIndicator()): SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: allpaidvideo,
          ),
        ),
      ),
    );
  }
}
