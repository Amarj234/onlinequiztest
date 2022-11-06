import 'dart:convert';
import 'package:dranchalsclass/homepage.dart';
import 'package:dranchalsclass/reg.dart';
import 'package:dranchalsclass/register.dart';
import 'package:dranchalsclass/sarvice.dart';
import 'package:http/http.dart' as http;
import 'package:dranchalsclass/admindashbord.dart';
import 'package:dranchalsclass/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';




class login extends StatefulWidget{


  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _passwordVisible=false;


  Serves serves=Serves();


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  Future Savedata() async{
    var url3 = Uri.parse(serves.url+"login.php");
    print(url3);
    var response = await http.post(url3,

        body: {

          'email': _emailController.text,
          'pass': _passController.text,
        });


    if (response.statusCode ==200) {
      var data =jsonDecode(response.body);

      if(data['check']=='1'){
        print(data['user'].toString());
        Navigator.push(
          context,MaterialPageRoute(builder: (context)=> dashbord()),
        );
        setsesiion(data['check'].toString(),data['user'].toString(),data['regid'].toString(),  );
      }else if(data['check']=='2'){

        print(data['check']);
        setsesiion(data['check'].toString(),data['user'].toString(),data['regid'].toString(),  );
        Navigator.push(
          context,MaterialPageRoute(builder: (context)=> admindash()),
        );
      }else {
        setState(() {
          SnackBar(content: Text('Somthig Error'));
        });

      }
      // Navigator.push(
      //   context,MaterialPageRoute(builder: (context)=> autoOtp()),
      // );
    }
  }

  setsesiion(String check,String name,String regid,)async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setString('check', check);
    prefs.setString('user', name);
    prefs.setString('regid', regid);
  }

  @override
  Widget build(BuildContext context) {
    var heightSc=MediaQuery.of(context).size.height;
    var widthSc=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF729CEF),
      body: Padding(
        padding:  EdgeInsets.only(top: heightSc*0.14),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(29),topLeft: Radius.circular(29))
          ),


          child: ListView(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                    //color: Colors.pinkAccent,
                    shape: BoxShape.circle
                ),
                child: Center(child:Image.asset('assets/logo.jpg',width: 200,)),
              ),


              Padding(
                padding:  EdgeInsets.only(top: 20,left: widthSc*0.05,right: widthSc*0.05),
                child: TextField(
                  controller:_emailController ,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.mail,size: 25,color: Color(0xFF729CEF),),
                      hintText: "Email",
                      hintStyle: TextStyle(fontSize: 15,color: Color(0xFF729CEF),fontWeight: FontWeight.w500)
                      ,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF729CEF))
                      ),
                      enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF729CEF))
                      )
                  ),
                ),
              ),



              Padding(
                padding:  EdgeInsets.only(top: 20,left: widthSc*0.05,right: widthSc*0.05),
                child: TextField(
                  obscureText: _passwordVisible ? false:true,
                  controller: _passController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIcon:IconButton(
                      icon:
                      Icon( _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,color: Color(0xFF729CEF),), onPressed: () {

                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.vpn_key_rounded,size: 25,color: Color(0xFF729CEF),),
                      hintText: "PASSWORD",
                      hintStyle: TextStyle(fontSize: 15,color: Color(0xFF729CEF),fontWeight: FontWeight.w500)
                      ,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF729CEF))
                      ),
                      enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: Color(0xFF729CEF))
                      )
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 13,right: 13,top: 20),
                child: RaisedButton(padding: EdgeInsets.only(top: 9,bottom: 9,),shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29),
                ),color: Color(0xFF729CEF),onPressed: (){
                  Savedata();
                },child: Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white)),),
              ),
SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 85),
                child: ElevatedButton(
                    style:  ElevatedButton.styleFrom(
                        primary:Color(0xFF80EAB5),
                      //  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    onPressed: (){
                      Navigator.push(
                        context,MaterialPageRoute(builder: (context)=> homePage()),
                      );
                    }, child: Row(
                  children: [
                    Icon(Icons.account_box_outlined),
                    Text('  View course')

                  ],
                )),
              ),
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text('New  User',style: TextStyle(color: Colors.black),),
                    TextButton(onPressed: (){
                      Navigator.push(
                        context,MaterialPageRoute(builder: (context)=> register()),
                      );

                    }, child: Text('Click')),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}