import 'dart:convert';
import 'dart:typed_data';
import 'package:dranchalsclass/Singlevideo.dart';
import 'package:dranchalsclass/sarvice.dart';
import 'package:dranchalsclass/vimoplayer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class coursevideo extends StatefulWidget {
  const coursevideo({Key? key, required this.cid}) : super(key: key);
final cid;
  @override
  State<coursevideo> createState() => _coursevideoState();
}

class _coursevideoState extends State<coursevideo> {


  List<ListTile> coursevideo=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allcourse();

  }
  Serves serves=Serves();
  Future allcourse() async {


    final uri = Uri.parse(serves.url+"coursevideo.php");


    var response = await http.post(uri,body: {
      'showdata':widget.cid,

    });
    coursevideo=[];
    var state= json.decode(response.body);
    print(state);
    setState(() {
      state.forEach((item) async{
        final List<int> codeUnits = item['videothumble'].codeUnits;
        final Uint8List unit8List = Uint8List.fromList(codeUnits);
        if (item['showhide'] == '1') {
          coursevideo.add(
            ListTile(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => Singlevideo(id: item['videopath'])),
                );
              },
              title: Text(item['video_titel'].toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,style: TextStyle(
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
              leading: Image.asset('assets/logo.jpg', height: 200,width: 100,),

            ),


          );
        }else{
          coursevideo.add(
            ListTile(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => MyHomePage1(id: item['videopath'],name:item['video_titel'],dis:item['discription'])),
                );
              },
              title: Text(item['video_titel'].toString(),
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
      body: coursevideo.length==0? Center(child: CircularProgressIndicator()): SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: coursevideo,
          ),
        ),
      ),
    );
  }
}
