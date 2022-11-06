import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'sarvice.dart';



class quizscreen extends StatefulWidget {
  const quizscreen({Key? key, required this.tid, required this.sub}) : super(key: key);
  final tid;
  final sub;

  @override
  State<quizscreen> createState() => _quizscreenState();
}

class _quizscreenState extends State<quizscreen> {
initState(){
  allPerson();
}


  Serves serves=Serves();
String? question;
String? subject;
String message ="Choose Ans";
String? image;
String? status;
int qid=1;

bool imageans=false;

  Future allPerson() async {
    crrect=null;
    colori=null;
    message ="Choose Ans";
   check=0;

print('fech data ${widget.tid+ widget.sub}');
    final uri = Uri.parse(serves.url+"quiztest.php");
    var response = await http.post(uri,body: {
      'id':qid.toString(),
      "subject":widget.tid,

    });

    var state= json.decode(response.body);

print("imag ${state}");
    setState(() {


      if(state['check']==1){
        if(state['ansimage']=='1'){
          imageans=true;
        }else{
          imageans=false;
        }
        getanswer();
        question= state['question'];
        subject= state['subject'];
        image= state['image'];
        status= state['status'];
        print(serves.url+image.toString());
      }else{
        _showMyDialog();
      }
    });
    }

    List<dynamic> allans=[];
getanswer() async{
  allans=[];
  final uri = Uri.parse(serves.url+"answer.php");
  var response = await http.post(uri,body: {
    'id':qid.toString(),
    "subject":widget.tid,

  });

  var state= json.decode(response.body);
  setState(() {
    allans=state;
  });

}
String? crrect;
String? colori;
int score=0;
int check=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sub.toString()),
      ),
      body: question==null ?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/25,),
                  Container(

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
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
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width:   200,
                    height:  50,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(child: Text(message.toString(),style: const TextStyle(fontSize: 20),)),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/60,),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("($qid)- $question",style: const TextStyle(fontSize: 20),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/60,),

Center(
  child: status== '2' ?  Image.network(serves.url+image.toString()):null,
),
                  Container(
                    child: allans.length==0 ?CircularProgressIndicator():  Column(
                      children: allans
                          .map<InkWell>((dynamic item) {
                         //   print(item);
                        return InkWell(
                          onTap: (){
                            setState((){
                              if(check<2) {

                                colori = null;
                                crrect = null;

                                if (item['correct'] == "1") {
          if(check==1){
            message="Average";
            score=score+5;
          }else{
            message="Very Good";
            score=score+10;
          }
                                  check=check+2;

                                  crrect = item['correct'];
                                  print(crrect);
                                } else {

                                  check=check+1;
                                  print(check);
                                  message="Try Again";
                                  colori = item['correct'] + item['ids'];
                                  if(check==2){
                                    Timer(Duration(seconds: 1), () {
          setState(() {
            crrect = '1';
            message="Very Bad";
          });
                                    } );
                                  }
                                }
                              }
                            });
                          },
                          child: Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height/60,),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(width: MediaQuery.of(context).size.width/1.3,
                                      child: imageans ? Image.network(serves.url+item['answer']): Text(
                                        item['answer'], maxLines: 2,)),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
width: imageans ?5:2,
                                    color:colori==item['correct']+item['ids'] ? Colors.red :Colors.black38 ,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
color: crrect==item['correct'] ?  Colors.green :null,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/30,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
                            onPressed: (){
                              _showMyDialog1();
                            }, child: Text("Exit")),
            SizedBox(width: MediaQuery.of(context).size.width/10,),
                        ElevatedButton(onPressed: (){
qid=qid+1;
allPerson();


                        }, child: Text("Next")),
                      ],
                    ),
                  ),
SizedBox(height: 20,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



Future<void> _showMyDialog() async {
  return showDialog<void>(

      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Card(
              child: AlertDialog(
                title:  Row(
                  children: [
                    Text('Your Score is ',
                      style: TextStyle(fontWeight: FontWeight.w600),),
                    Text('$score',
                      style: TextStyle(fontWeight: FontWeight.w800,color: Colors.redAccent),),
                   Text(' Out Of  ',
                      style: TextStyle(fontWeight: FontWeight.w600),),
                    Text(' ${(qid-1)*10}',
                      style: TextStyle(fontWeight: FontWeight.w800,color: Colors.greenAccent),),
                  ],
                ),
                // content: SingleChildScrollView(
                // //   child: ListBody(
                // //     children: const <Widget>[
                // //
                // //     ],
                // //   ),
                // // ),
                actions: <Widget>[


                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width/10,),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
                            onPressed: (){
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => dashbord()),
                              );
                            }, child: Text("Ok")),


                      ],
                    ),
                  )






                ],
              ),
            );
          },
        );
      }
  );
}


Future<void> _showMyDialog1() async {
  return showDialog<void>(

      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Card(
              child: AlertDialog(
                title: const Text('Are You Sure want to Exit',
                  style: TextStyle(fontWeight: FontWeight.w800),),
                // content: SingleChildScrollView(
                // //   child: ListBody(
                // //     children: const <Widget>[
                // //
                // //     ],
                // //   ),
                // // ),
                actions: <Widget>[


                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15))),
                            onPressed: (){
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => dashbord()),
                              );
                            }, child: Text("Yes Exit")),
                        SizedBox(width: MediaQuery.of(context).size.width/10,),
                        ElevatedButton(onPressed: (){
                        Navigator.pop(context);


                        }, child: Text("NO")),
                      ],
                    ),
                  )






                ],
              ),
            );
          },
        );
      }
  );
}

}
