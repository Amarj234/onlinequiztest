import 'dart:convert';
import 'package:dranchalsclass/mymdal.dart';
import 'package:http/http.dart' as http;
import 'package:dranchalsclass/dashboard.dart';
import 'package:dranchalsclass/sarvice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class register extends StatefulWidget{



  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  Serves serves=Serves();

  final name  = TextEditingController();

  final mobile = TextEditingController();

  final  email  =  TextEditingController();

  final  address  =  TextEditingController();

  final  dental  =  TextEditingController();

  final percentage = TextEditingController();

  final password  = TextEditingController();

  final cpassword = TextEditingController();

  String? gender;

  String? checkstuden;

  String? crrentbatch;

  String? category;

  String? passmatch;

  String? course;

  List<DropdownMenuItem> allcore=[];

  Future allcourse() async {


    final uri = Uri.parse(serves.url+"addcourse.php");
    var response = await http.post(uri,body: {
      'showdata':"",

    });
    allcore=[];
    var state= json.decode(response.body);
    setState(() {
      state.forEach((item) {
        allcore.add(
          DropdownMenuItem(child: Text(item['coursename']), value: item['id']),


        );
      }
      );
    });
  }

  Future Registerf() async{

    if(password.text==cpassword.text) {

      final uri = Uri.parse(serves.url + "register.php");
      var request = http.MultipartRequest('POST', uri);

      request.fields['name'] = name.text;
      request.fields['mobile'] = mobile.text;
      request.fields['email'] = email.text;
      request.fields['address'] = address.text;
      request.fields['dental'] = dental.text;
      request.fields['percentage'] = percentage.text;
      request.fields['password'] = password.text;
      request.fields['gender'] = gender.toString();
      request.fields['checkstuden'] = checkstuden.toString();
      request.fields['crrentbatch'] = crrentbatch.toString();
      request.fields['category'] = category.toString();
      request.fields['course'] = course.toString();

      var response = await request.send();

      if (response.statusCode == 200) {
        var response1 = await http.Response.fromStream(response);
        print('amarjeet ${response1.body}');
        var data = jsonDecode(response1.body);

        setsession(data.toString());
      } else {
        print('Image Not Uploded');
      }
    }else{
      setState(() {
        passmatch="Password not Match";
      });
    }

  }

  setsession(String data) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setString('check', '1');
    prefs.setString('user', name.text);
    prefs.setString('regid', data);
    Navigator.push(
      context,MaterialPageRoute(builder: (context)=> dashbord()),
    );

  }

  bool sendotp =true;

  bool otpbox =false;

  final _formKey = GlobalKey<FormState>();

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


                ),
                child: Center(child: Image.asset('assets/logo.jpg')),
              ),



              addtextFilds(name:"Full Name" ,hinttext:"Full Name", controll:name),
              addtextFilds(name:"E-mail Address" ,hinttext:"E-mail Address", controll:email),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: mobile,
                    style: TextStyle(color: Colors.black,fontSize: 20,),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: "Whatsapp Number",
                      hoverColor: Colors.black12,
                      hintText: "Whatsapp Number",
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(

                  child: TextFormField(

                    style: TextStyle(color: Colors.black,fontSize: 20,),
                    textAlign: TextAlign.start,
                    controller: address,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: 'Address',
                      hoverColor: Colors.black12,
                      hintText: 'Address',

                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: DropdownButtonFormField(
                    hint: Text('Gender'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ), onChanged: (value) {
                    gender=value.toString();
                  },
                    items: [
                      DropdownMenuItem(child: Text("Male"), value: "Male"),
                      DropdownMenuItem(child: Text("Female"), value: "Female"),
                      DropdownMenuItem(child: Text("other"), value: "other"),
                    ],
                  ),
                ),
              ),

              addtextFilds(name:"Dental College Name" ,hinttext:"Dental College Name", controll:dental),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: DropdownButtonFormField(
                    hint: Text('Are You Student Or Dentist'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ), onChanged: (value) {
                    checkstuden=value.toString();
                  },
                    items: [
                      DropdownMenuItem(

                          child: Text("I am a Students" ), value: "I am a Students"),
                      DropdownMenuItem(child: Text("I am a Doctor"), value: "I am a Doctor"),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: DropdownButtonFormField(
                    hint: Text('Current Batch'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ), onChanged: (value) {
                    crrentbatch=value.toString();
                  },
                    items: [
                      DropdownMenuItem(child: Text("1st Year"), value: "1st Year"),
                      DropdownMenuItem(child: Text("2st Year"), value: "2st Year"),
                      DropdownMenuItem(child: Text("3st Year"), value: "3st Year"),
                      DropdownMenuItem(child: Text("4st Year"), value: "4st Year"),
                      DropdownMenuItem(child: Text("Intern"), value: "Intern"),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 60,
                  child: DropdownButtonFormField(
                    hint: Text('Category'),

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ), onChanged: (value) {
                    category=value.toString();
                  },
                    items: [
                      DropdownMenuItem(child: Text("Open",style:TextStyle(fontSize: 18),), value: "Open"),
                      DropdownMenuItem(child: Text("ST"), value: "ST"),
                      DropdownMenuItem(child: Text("SC"), value: "SC"),
                      DropdownMenuItem(child: Text("NT"), value: "NT"),
                      DropdownMenuItem(child: Text("SEBC"), value: "SEBC"),
                    ],
                  ),
                ),
              ),

              addtextFilds(name:"Aggregate Percentage" ,hinttext:"Aggregate Percentage", controll:percentage),




              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: password,
                    style: TextStyle(color: Colors.black,fontSize: 20,),
                    textAlign: TextAlign.start,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: "Password",
                      hoverColor: Colors.black12,
                      hintText: "Password",
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: cpassword,
                    style: TextStyle(color: Colors.black,fontSize: 20,),
                    textAlign: TextAlign.start,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.blue)),
                      labelText: "Confirm Password",
                      hoverColor: Colors.black12,
                      hintText: "Confirm Password",
                      errorText: passmatch,
                    ),
                  ),
                ),
              ),




              InkWell(
                onTap: (){
                  Registerf();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 13,right: 13,top: 20),
                  child: RaisedButton(padding: EdgeInsets.only(top: 9,bottom: 9,),shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29),
                  ),color: Color(0xFF729CEF),onPressed: (){

                  },child: Text("CREATE ACCOUNT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white)),),
                ),
              ),
SizedBox(height: 20,),

              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text('Already Register',style: TextStyle(color: Colors.black),),
                    TextButton(onPressed: (){
                      Navigator.push(
                        context,MaterialPageRoute(builder: (context)=> login()),
                      );

                    }, child: Text('Click')),
                  ],
                ),
              ),
              SizedBox(height: 200,)
            ],
          ),
        ),
      ),
    );
  }


  Widget addtextFilds({required String name ,required String hinttext,required TextEditingController controll, }){
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 60,
        child: TextFormField(
          style: TextStyle(color: Colors.black,fontSize: 20,),
          textAlign: TextAlign.start,
          controller: controll,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            border:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue)),
            labelText: name,
            hoverColor: Colors.black12,
            hintText: hinttext,
          ),
        ),
      ),
    );



  }

}