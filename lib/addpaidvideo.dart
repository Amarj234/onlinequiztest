import 'dart:convert';

import 'package:dranchalsclass/sarvice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class addpaidvideo extends StatefulWidget {
  const addpaidvideo({Key? key}) : super(key: key);

  @override
  State<addpaidvideo> createState() => _addpaidvideoState();
}

class _addpaidvideoState extends State<addpaidvideo> {

  String uid ='0';
  String button ='Save';

  final title=TextEditingController();
  final price=TextEditingController();
  final vimoid=TextEditingController();
  final discription=TextEditingController();
  List<DropdownMenuItem> allcore=[];
  void initState() {
    super.initState();
    allPerson();
    allcourse();
  }
  List<Widget> image=[];

  Savevideo() async{

    EasyLoading.show(status: 'loading...');
    final uri = Uri.parse(serves.url+"addpaidvideo.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['title'] =  title.text;
    request.fields['discription'] =discription.text;

    request.fields['vimoid'] = vimoid.text;
    request.fields['price'] = price.text;
    var videos = await http.MultipartFile.fromPath("video", video.toString());
    request.files.add(videos);
    var response = await request.send();
    var response1 = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      EasyLoading.showSuccess('Great Success!');
      title.text="";
      vimoid.text="";
      discription.text="";
      EasyLoading.dismiss();
    }else{
      EasyLoading.showError('Failed with Error');
    }
    setState(() {

    });
  }
  String? video;
  String? imagebyt;
  choosefile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
// print(result);
    if(result != null) {

      PlatformFile file = result.files.first;
      video=file.path.toString();
    }


  }

  List<DataRow> state2=[];
  Serves serves=Serves();

  Future allcourse() async {

    state2=[];
    final uri = Uri.parse(serves.url+"addcourse.php");
    var response = await http.post(uri,body: {
      'showdata':"",

    });

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




  Future allPerson() async {

    state2=[];
    final uri = Uri.parse(serves.url+"addcourse.php");
    var response = await http.post(uri,body: {
      'showdata':"",

    });

    var state= json.decode(response.body);
    setState(() {
      state.forEach((item) {
        state2.add( DataRow(

            cells: [

              DataCell(Text(item['id'])),
              DataCell(Text(item['coursename'])),
              DataCell(Text(item['discription'])),
              DataCell(
                  IconButton(
                    icon: const Icon(Icons.create,color: Colors.green,), onPressed: () {
                    Update(item['id'],item['coursename'],item['discription']);
                  },
                  )
              ),
            ]
        ),
        );
      }
      );
    });
  }
  void Update(upid,value,did){
    print(upid);
    setState(() {
      button="Update";
      discription.text=did.toString();

      uid=upid;
    });

  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Paid Video'),


      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SizedBox(
            height:  MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(

                    child: Image.asset('assets/logo.jpg',width: 200,),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(

                    child: TextFormField(

                      style: const TextStyle(color: Colors.black,fontSize: 20,),
                      textAlign: TextAlign.start,
                      controller: title,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border:  const OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: const BorderSide(color: Colors.blue)),
                        labelText: 'Video Title',
                        hoverColor: Colors.black12,
                        hintText: 'Video Title',

                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(

                    child: TextFormField(

                      style: const TextStyle(color: Colors.black,fontSize: 20,),
                      textAlign: TextAlign.start,
                      controller: vimoid,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border:  const OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: const BorderSide(color: Colors.blue)),
                        labelText: 'Add vimeoid',
                        hoverColor: Colors.black12,
                        hintText: 'Enter vimeoid',

                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(

                    child: TextFormField(

                      style: const TextStyle(color: Colors.black,fontSize: 20,),
                      textAlign: TextAlign.start,
                      controller: price,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border:  const OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: const BorderSide(color: Colors.blue)),
                        labelText: 'Price',
                        hoverColor: Colors.black12,
                        hintText: 'Enter Price',

                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(

                    child: TextFormField(

                      style: const TextStyle(color: Colors.black,fontSize: 20,),
                      textAlign: TextAlign.start,
                      controller: discription,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue)),
                        labelText: 'Video Discription',
                        hoverColor: Colors.black12,
                        hintText: 'Video Discription',

                      ),
                      maxLines: 3,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),


                InkWell(
                  onTap: (){
                    choosefile();
                  },
                  child: Container(

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
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.image_aspect_ratio_rounded,size: 30,color: Colors.blue,),
                          const Text('Video Thumbnail',style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Column(
                  children: image,
                ),

                const SizedBox(
                  height: 10,
                ),

                ElevatedButton(onPressed: (){
                  Savevideo();

                },
                    child: Text(button)),


                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SizedBox(
                    height:  MediaQuery.of(context).size.height/4,

                    child: SingleChildScrollView(
                      scrollDirection:  Axis.horizontal,
                      child: SingleChildScrollView(

                          scrollDirection: Axis.vertical,
                          // physics: NeverScrollableScrollPhysics(),
                          child: null
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
