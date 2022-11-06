import 'package:flutter/material.dart';

import 'quizscreen.dart';


class Quizdetails extends StatelessWidget {
  const Quizdetails({Key? key, required this.name, required this.image, required this.videoid, required this.dis, required this.price, required this.cid}) : super(key: key);
final name;
final image;
final videoid;
final dis;
final price;
final cid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dr Anchals Test"),
      ),
      body: SafeArea(
          child: Container(
            color: Colors.black12,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/12,),
                Center(child: Text(name.toString(),style: TextStyle(fontSize:20,fontWeight: FontWeight.w600))),
                SizedBox(height: MediaQuery.of(context).size.height/40,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: ClipRRect(

                      borderRadius: BorderRadius.circular(8.0),child: Image.network(image))),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/40,),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(child: Text(dis.toString(),style: TextStyle(fontSize:16,))),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/8,),

                ElevatedButton(onPressed: (){

                  Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => quizscreen(tid:cid,sub:name)),
                  );
                }, child: Text('Start')),
              ],
            ),

          )
      ),
    );
  }
}
