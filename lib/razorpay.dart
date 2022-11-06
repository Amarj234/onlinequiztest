import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dranchalsclass/sarvice.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';


class razorpay extends StatefulWidget {
  const razorpay({Key? key, required this.cid, required this.price, required this.name, required this.check}) : super(key: key);
final cid;
final price;
final name;
final check;
  @override
  _razorpayState createState() => _razorpayState();
}

class _razorpayState extends State<razorpay> {

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    allPerson();
  }

  Serves serves=Serves();

 String? sname;
  String? smobile;
  String? semail;


  Future allPerson() async {

    SharedPreferences prefs =await SharedPreferences.getInstance();
    var regid=  prefs.getString('regid');
    print('golu $regid');
    final uri = Uri.parse(serves.url+"fechstudent.php");
    var response = await http.post(uri,body: {
      'regid':regid,

    });

    var state= json.decode(response.body);
      state.forEach((item) {

smobile=item['wmobile'];
semail=item['email'];
print('golu $state');

openCheckout();
      });




          }


  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_live_uvpp9eA58IzGvU',
      'amount': int.parse(widget.price)*100,
      'name': widget.cid.toString(),
      'description': widget.name.toString(),
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': smobile, 'email': semail},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    print('Success Response: $response');

    SharedPreferences prefs =await SharedPreferences.getInstance();
    var regid=  prefs.getString('regid');
    var user=  prefs.getString('user');
    final uri = Uri.parse(serves.url+"tansection.php");
    var response1 = await http.post(uri,body: {
      'regid':regid.toString(),
      'sname':user.toString(),
      'smobile':smobile.toString(),
      'semail':semail.toString(),
      'paymentmethod':(response.paymentId).toString(),
      'ptype':'card',
      'courseid':widget.cid.toString(),
      'coursename':widget.name.toString(),
      'price':widget.price.toString(),
      'stutus':'1',
      'check':widget.check.toString(),


    });

    var state= json.decode(response1.body);

if(state==1){

  Navigator.push(
    context, MaterialPageRoute(builder: (context) => dashbord()),

  );
}




    print(response.orderId);
    print(response.paymentId);
    print(response.signature);
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
    Navigator.pop(context);

  }

  void _handleExternalWallet(ExternalWalletResponse response) async{
    print('External SDK Response: $response');

    SharedPreferences prefs =await SharedPreferences.getInstance();
    var regid=  prefs.getString('regid');
    final uri = Uri.parse(serves.url+"tansection.php");
    var response1 = await http.post(uri,body: {
      'regid':regid,
      'sname':sname,
      'smobile':smobile,
      'semail':semail,
      'paymentmethod':response.walletName,
      'ptype':response.walletName,
      'courseid':widget.cid,
      'coursename':widget.name,
      'price':widget.price,
      'stutus':'1',
      'check':widget.check.toString(),


    });

    var state= json.decode(response1.body);

if(state==1){

  Navigator.push(
    context, MaterialPageRoute(builder: (context) => dashbord()),

  );
}



  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
