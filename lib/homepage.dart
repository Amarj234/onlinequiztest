import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dranchalsclass/constants.dart';
import 'package:dranchalsclass/details_screen.dart';
import 'package:dranchalsclass/mymdal.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:flutter/material.dart';

import 'allcorce.dart';
import 'sarvice.dart';

class homePage extends StatefulWidget {
  const homePage({key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {




  DateTime? currentBackPressTime;
  // Future<bool> onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (
  //       now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     SystemNavigator.pop();
  //     exit(0);
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }
  Serves serves=Serves();
  List<Padding> categories=[];
  allPerson() async {

    final uri = Uri.parse(serves.url+"addcourse.php");
    var response = await http.post(uri,body: {
      'showdata':Searchcourse.text.toString(),

    });
    print(Searchcourse.text);
    if (response.statusCode == 200) {
      categories = [];
    var state= json.decode(response.body);


      setState(() {
        state.forEach((item) {
          categories.add(Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      DetailsScreen(name:item['coursename'].toString(),image:serves.url +
                          item['thumbnail'],price:item['prices'],dis:item['discription'],videoid:item['demovideoid'],cid:item['id'])),
                );
              },
              child: Container(
                  height: 270,
                  width: 160,
                  margin: EdgeInsets.only(right: 10),
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              child: Image.network(serves.url +
                                  item['thumbnail'].toString(),
                                fit: BoxFit.cover,
                                height: 120,
                                width: 155,
                              ),
                            ),
                            Positioned(
                                bottom: -20, right: 10, child: Container(
                              height: (40),
                              width: (40),
                              alignment: Alignment.center,
                              decoration:
                              BoxDecoration(color: Colors.red,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 3),
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.4))
                                  ]),
                              child: FittedBox(
                                child: Text(
                                  "₹" + item['prices'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assets/images/marketing.png'),
                                ),
                                title: Text(
                                  item['coursename'].toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                item['discription'].toString(),
                                overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.menu_book_outlined,
                                    color: Colors.redAccent,),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Lessons")
                                ],
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  )),
            ),
          ),


          );
        }
        );
      });
    }

  }

  void initState() {
    super.initState();
    allPerson();
  }

final Searchcourse=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 50, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset("assets/icons/menu.svg"),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,MaterialPageRoute(builder: (context)=> login()),
                          );
                        },
                          child: Image.asset("assets/user.png",width: 40,)),
                    ],
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Image.asset('assets/logo.jpg',width: 200,)),
                  ),
                  SizedBox(height: 30),

                  Text("Find a course you want to learn", style: kSubheadingextStyle),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: TextField(
                        controller: Searchcourse,
                        onChanged: (value) {
                        if(Searchcourse.text!=null){

                          allPerson();
                        }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Search Your course",
                          prefixIcon: Icon(Icons.search),

                        ),
                      ),
                    ),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Our course", style: kTitleTextStyle),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,MaterialPageRoute(builder: (context)=> allcourse()),
                          );
                      },
                        child: Text(
                          "See All",
                          style: kSubtitleTextSyule.copyWith(color: kBlueColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: categories.length ==0 ? Center(child: CircularProgressIndicator()):Row(
                      children:  categories,
                    ),
                  ),



                ],
              ),
            ),

            SizedBox(height: 30,),
            Container(
              height: 90,
              color: Color(0xFF1B2850),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('FOLLOW US ON:',style: TextStyle(color: Colors.white,fontSize: 15),),
                  ),
                  SizedBox(width: 20,),
Image.asset('assets/face.png',width: 30,),
                  SizedBox(width: 10,),
                  Image.asset('assets/twit.png',width: 30,),
                  SizedBox(width: 10,),
                  Image.asset('assets/link.png',width: 30,),
                  SizedBox(width: 10,),
                  Image.asset('assets/insta.png',width: 30,),
                ],
              ),
            )
          ],
        ),
      ),
    );


  }


 }
