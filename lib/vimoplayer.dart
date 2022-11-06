import 'package:flutter/material.dart';

import 'package:vimeoplayer_trinity/vimeoplayer_trinity.dart';



class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key, required this.id, required this.dis, required this.name}) : super(key: key);
final id;
final dis;
 final name;

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
//  String videoId = '70591644';
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
  }
  @override
  Widget build(BuildContext context) {
  bool isckeck=true;



    return Scaffold(

       // backgroundColor: Color(0xFFB1A375), //FF15162B // 0xFFF2F2F2
        appBar: MediaQuery.of(context).orientation == Orientation.portrait
            ? AppBar(
          leading: BackButton(color: Colors.white),
          title: Text('Dr Anchals Video'),
        //  backgroundColor: Color(0xAABF21D9),
        )
            : PreferredSize(
          child: Container(
            color: Colors.transparent,
          ),
          preferredSize: Size(0.0, 0.0),
        ),
        body:Column(
          children: [
            VimeoPlayer(id: widget.id, autoPlay: true, allowFullScreen: true),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Text(widget.name.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: isckeck,
                  child: Text(widget.dis.toString(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),

              ),
            )
          ],
        ));
  }
}

//382169007