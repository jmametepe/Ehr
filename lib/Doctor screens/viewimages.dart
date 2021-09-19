import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Doctor%20screens/photoview.dart';
import 'package:hello_world/Shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;




class ViewImages extends StatefulWidget {
  final String doctor;
  final String label;
  final String id;

  ViewImages({this.label, this.doctor, this.id});

  @override
  _ViewImagesState createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImages> {
  static final _formKey = GlobalKey<FormState>();
  String tname = "";
  String tnote = "";
  String tresult = "";
  String url;
  var _image;
  final imagepicker = ImagePicker();
  bool uploading = false;
  firebase_storage.StorageReference ref;
  @override
  Widget build(BuildContext context) {
    String image;
    String doctorr;
    String date;
    String url;
    String note;
    String profession;

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        title: Text("Images"),
        actions: [
          IconButton(icon: Icon(Icons.add, size: 40, ),onPressed: (){
            showModalBottomSheet(context: context, builder: (context){
              //final _formKey = GlobalKey<FormState>();
              //String dname ;
              //String dnote ;
              return SingleChildScrollView(
                child: Container(
                  child: Form(
                    key: _formKey,

                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Text("Upload Image",
                          style: TextStyle(fontSize: 18),),

                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Image name"),
                          validator: (val) => val.isEmpty? 'Please Enter a name' : null,
                          onChanged: (val) {
                            setState(() => tname = val);

                          },
                        ),

                        SizedBox(height: 20,),

                        // TextFormField(
                        //   decoration: textInputDecoration.copyWith(hintText: "Short description"),
                        //   validator: (val) => val.isEmpty? 'Please Enter a Result' : null,
                        //   onChanged: (val) {
                        //     setState(() => tresult = val);
                        //
                        //   },
                        // ),
                        //
                        // SizedBox(height: 20,),


                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Note"),
                          onChanged: (val) => setState(() {
                            tnote = val;
                          }),
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.camera_alt, color: Colors.blue, size: 50,), onPressed: () async {
                              var image = await imagepicker.pickImage(source: ImageSource.camera);
                              if(image == null){
                                return null;
                              }else{
                                _image = File(image.path);
                              }
                            },),


                            IconButton(icon: Icon(Icons.photo, color: Colors.blue, size: 50, semanticLabel: "Gallery",), onPressed: () async{
                              var image = await imagepicker.pickImage(source: ImageSource.gallery);
                              if(image == null){
                                return null;
                              }else{
                                _image = File(image.path);
                              }

                            },)
                          ],
                        ),

                        SizedBox(height: 40,),

                        _image != null?
                            Container(
                              height: 220,
                              padding: EdgeInsets.all(15),
                              child: Image.file(_image),
                            ): Container(),

                        SizedBox(height: 10,),

                        uploading == true?
                        Container(
                          child: CircularProgressIndicator(color: Colors.red,),
                        ): Container(),


                        _image != null? RaisedButton(
                          color: Colors.red,
                          child: Text("Upload"),
                          onPressed: ()async{
                            setState(() {
                              uploading = true;
                            });
                            ref = firebase_storage.FirebaseStorage.instance
                                .ref()
                                .child("images/${Path.basename(_image.path)}");
                            await ref.putFile(_image).onComplete;
                            print("uploaded");
                            await ref.getDownloadURL().then((value) {
                              Firestore.instance.collection("biodata")
                                  .document(widget.id)
                                  .collection("images")
                                  .add({
                                "image name": tname,
                                "uploaded by": widget.doctor,
                                "profession": widget.label,
                                "note": tnote,
                                "date": DateTime.now().year.toString() + "/" + DateTime.now().month.toString() + "/" + DateTime.now().day.toString(),
                                "url" : value
                              }).then((value) {
                                setState(() {
                                  _image = null;
                                  uploading = false;

                                });
                                Navigator.of(context).pop();
                              });
                            });


                          },
                        ): Container(),

                        SizedBox(height: 10,),



                      ],
                    ),

                  ),
                ),
              );
            });

          },)
        ],
      ),

      body: StreamBuilder(
          stream: Firestore.instance.collection("biodata").document(widget.id).collection("images").orderBy("date", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(color: Colors.red,),
              );
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                image = document["image name"];
                doctorr = document["uploaded by"];
                date = document["date"];
                url = document["url"];
                note = document["note"];
                profession = document["profession"];



                return Card(
                  color: Colors.white,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width/0.8,
                      //height: MediaQuery.of(context).size.height/5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Image name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(image, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                          Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(date, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("uploaded by:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(doctorr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("Profession", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(profession, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("Note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(note, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Row(
                            children: <Widget>[
                              TextButton(child: Text("View"), onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoViewer(url: url,)));
                                return PhotoViewer();
                              },),
                              TextButton(child: Text("Download"), onPressed: (){},),
                            ],
                          )

                        ],
                      )
                  ),

                );


              }).toList(),

            );
          }
      ),


    );
  }
}
