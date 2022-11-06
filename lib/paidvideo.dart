import 'dart:convert';

import 'package:dranchalsclass/details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:dranchalsclass/sarvice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'videodetails.dart';

class paidvideo extends StatefulWidget {
  const paidvideo({Key? key}) : super(key: key);

  @override
  State<paidvideo> createState() => _paidvideoState();
}

class _paidvideoState extends State<paidvideo> {


  List<Card> state2=[];
  Serves serves=Serves();

  Future allPerson() async {


    final uri = Uri.parse(serves.url+"allpaidvideo.php");
    var response = await http.post(uri,body: {
      'showdata':"",

    });
    state2=[];
    var state= json.decode(response.body);
    setState(() {
      if(state.length==0){
        state2.add(
            Card(
              child: Center(child: Text("Video Not Found")),
            )
        );
      }
      state.forEach((item) {
        state2.add(    Card(
          child: InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    videodetails(name:item['name'].toString(),image:serves.url +
                        item['thumbnail'],price:item['price'],dis:item['discription'],videoid:'2',cid:item['id'])),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(serves.url +
                    item['thumbnail'].toString(),width:100,height: 100,),
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,20,0,0),
                  child: Column(

                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.5,
                        child: Text(item['name'].toString(),style: GoogleFonts.lato(
                          textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 18,fontWeight: FontWeight.w600),
                        ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(height: 5,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.5,
                        child: Text(item['discription'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(color: Colors.black, letterSpacing: .5,fontSize: 16),)),
                      ),
                    ],),
                )

              ],
            ),
          ),
        )
        );
      });
    });

    setState(() {});
  }


  void initState() {
    super.initState();
    allPerson();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xFFC0F6C6),
        title: Text('Paid Video'),
      ),
      body: state2.length==0? Center(child: CircularProgressIndicator()): ListView(
        children: state2,
      ),
    );
  }
}
