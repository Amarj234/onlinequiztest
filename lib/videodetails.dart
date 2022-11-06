
import 'package:dranchalsclass/vimoplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

import 'mymdal.dart';
import 'razorpay.dart';

class videodetails extends StatefulWidget {
  const videodetails({Key? key,required this.name  , required this.image,required this.price, required this.dis,required this.videoid, required this.cid }) : super(key: key);
  final String name;
  final String image;
  final String price;
  final String dis;
  final String videoid;
  final String cid;
  @override
  _videodetailsState createState() => _videodetailsState();
}

class _videodetailsState extends State<videodetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F4EF),
          image: DecorationImage(
            image: NetworkImage(widget.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, top: 50, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                          onTap:(){
                            Navigator.pop(context);
                          },child: SvgPicture.asset("assets/icons/arrow-left.svg")),
                      SvgPicture.asset("assets/icons/more-vertical.svg"),
                    ],
                  ),
                  SizedBox(height: 30),
                  ClipPath(
                    clipper: BestSellerClipper(),
                    child: Container(
                      color: kBestSellerColor,
                      padding: EdgeInsets.only(
                          left: 10, top: 5, right: 20, bottom: 5),
                      child: Text(
                        "DrAnchals".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(widget.name, style: kHeadingextStyle),
                  SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset("assets/icons/person.svg"),
                      SizedBox(width: 5),
                      Text("18K"),
                      SizedBox(width: 20),
                      SvgPicture.asset("assets/icons/star.svg"),
                      SizedBox(width: 5),
                      Text("4.8")
                    ],
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "₹  "+widget.price,
                          style: kHeadingextStyle.copyWith(fontSize: 32),
                        ),
                        TextSpan(
                          text: "₹ "+int.parse(widget.price).toString(),
                          style: TextStyle(
                            color: kTextColor.withOpacity(.5),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft:  Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Course Content", style: kTitleTextStyle),
                            SizedBox(height: 30),
                            SizedBox(
                              width:  MediaQuery.of(context).size.width/1.1,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context, MaterialPageRoute(
                                      builder: (context) => MyHomePage1(id: widget.videoid,name:widget.name ,dis:widget.dis)),
                                  );
                                },
                                child: CourseContent(
                                  number: "01",
                                  duration: 5.35,
                                  title: "Play After Purchase",
                                  isDone: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              width:  MediaQuery.of(context).size.width/1.1,
                              child: Text("Description", style: kTitleTextStyle),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              width:  MediaQuery.of(context).size.width/1.1,
                              child: Text(widget.dis, style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 50,
                              color: kTextColor.withOpacity(.1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(14),
                              height: 56,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFEDEE),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: SvgPicture.asset(
                                  "assets/icons/shopping-bag.svg"),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: InkWell(
                                onTap:() async{

                                  SharedPreferences prefs =await SharedPreferences.getInstance();
                                  var check=  prefs.getString('check');

                                  if(check!=null){

                                    Navigator.push(
                                        context,MaterialPageRoute(builder: (context)=> razorpay(name:widget.name,price:widget.price,cid:widget.cid,check:widget.videoid))
                                    );
                                  }else{


                                    Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => login()),

                                    );


                                  }
                                },


                                child: Container(
                                  alignment: Alignment.center,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: kBlueColor,
                                  ),
                                  child: Text(
                                    "Buy Now",
                                    style: kSubtitleTextSyule.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseContent extends StatelessWidget {
  final String? number;
  final double? duration;
  final String? title;
  final bool? isDone;
  const CourseContent({
    Key? key,
    this.number,
    this.duration,
    this.title,
    this.isDone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(
            number!.toString(),
            style: kHeadingextStyle.copyWith(
              color: kTextColor.withOpacity(.15),
              fontSize: 32,
            ),
          ),
          SizedBox(width: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$duration mins\n",
                  style: TextStyle(
                    color: kTextColor.withOpacity(.5),
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: kSubtitleTextSyule.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kGreenColor.withOpacity(isDone! ? 1 : .5),
            ),
            child: Icon(Icons.play_arrow, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class BestSellerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
