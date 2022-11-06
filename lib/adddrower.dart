import 'package:dranchalsclass/homepage.dart';
import 'package:dranchalsclass/sarvice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Adddroewr extends StatefulWidget {
  const Adddroewr({Key? key  }) : super(key: key);

  @override
  _AdddroewrState createState() => _AdddroewrState();
}

class _AdddroewrState extends State<Adddroewr> {

  int select=0;

  void focosicon(int index){
    setState(() {
      select=index;
    });
  }



  Serves serves=Serves();
  String? name;
  getname()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    setState(() {
      name=prefs.getString('user');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 200,
              child: DrawerHeader(


                child: Container(

                  child: ListView(
                    children: [
                      CircleAvatar(radius: (52),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius:BorderRadius.circular(0),
                            child: Image.asset('assets/logo.jpg'),
                          )
                      ),
                      SizedBox(height: 20,),
                      Container(

                        child:  Text(name.toString() ,style: TextStyle(fontSize: 30,color: Colors.blue),),
                      ),


                    ],
                  ),
                ),

              ),
            ),
            Divider(
              thickness: 3,
              endIndent: 10,
              indent: 10,
            ),
            ListTile(
              selected: select==0,
              leading: Icon(Icons.home),
              title: Text("Home",style: TextStyle(fontSize: 20,color: Colors.black),),
              onTap: (){
                focosicon(0);

              },
            ),
            ListTile(
              selected: select==1,
              leading: Icon(Icons.messenger_rounded),
              title: Text("Message",style:  TextStyle(fontSize: 20,color: Colors.black),),
              onTap: (){
                focosicon(1);

              },
            ),
            ListTile(
              selected: select==2,
              leading: Icon(Icons.account_box_outlined),
              title: Text("About",style:  TextStyle(fontSize: 20,color: Colors.black),),
              onTap: (){
                focosicon(2);
                // Navigator.push(
                //   context,MaterialPageRoute(builder: (context)=> MyHomePage2()),
                // );
              },
            ),






            ListTile(
              selected: select==5,
              leading: Icon(Icons.local_police_rounded),
              title: Text("Policy",style:  TextStyle(fontSize: 20,color: Colors.black),),
              onTap: (){
                focosicon(5);


              },
            ),

            ListTile(
              selected: select==5,
              leading: Icon(Icons.logout),
              title: Text("Logout",style:  TextStyle(fontSize: 20,color: Colors.black),),
              onTap: ()async{
                focosicon(5);
                SharedPreferences prefs =await SharedPreferences.getInstance();
prefs.clear();
                Navigator.push(
                  context,MaterialPageRoute(builder: (context)=> homePage()),
                );
              },
            ),


          ],
        ),


      ),
    );
  }
}
