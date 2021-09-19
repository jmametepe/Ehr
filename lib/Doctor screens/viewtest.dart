import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Shared/constants.dart';



class ViewTest extends StatefulWidget {
  final String doctor;
  final String label;
  final String id;

  ViewTest({this.label, this.doctor, this.id});

  @override
  _ViewTestState createState() => _ViewTestState();
}

class _ViewTestState extends State<ViewTest> {
  static final _formKey = GlobalKey<FormState>();
  String tname = "";
  String tnote = "";
  String tresult = "";
  @override
  Widget build(BuildContext context) {
    String test;
    String doctorr;
    String date;
    String result;
    String note;
    String profession;

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        title: Text("Patient Tests"),
        actions: [
          widget.label == "Nurse" || widget.label== "Lab Technician"? IconButton(icon: Icon(Icons.add, size: 40, ),onPressed: (){
            showModalBottomSheet(context: context, builder: (context){
              //final _formKey = GlobalKey<FormState>();
              //String dname ;
              //String dnote ;
              return Container(
                child: Form(
                  key: _formKey,

                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text("Add Test",
                        style: TextStyle(fontSize: 18),),

                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Test Name"),
                        validator: (val) => val.isEmpty? 'Please Enter a Test' : null,
                        onChanged: (val) {
                          setState(() => tname = val);

                        },
                      ),

                      SizedBox(height: 20,),

                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Result"),
                        validator: (val) => val.isEmpty? 'Please Enter a Result' : null,
                        onChanged: (val) {
                          setState(() => tresult = val);

                        },
                      ),

                      SizedBox(height: 20,),


                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Note"),
                        onChanged: (val) => setState(() {
                          tnote = val;
                        }),
                      ),

                      SizedBox(
                        height: 40,
                      ),

                      RaisedButton(
                        color: Colors.red,
                        child: Text("Enter"),
                        onPressed: ()async{
                          await Firestore.instance
                              .collection("biodata")
                              .document(widget.id)
                              .collection("tests")
                              .add({
                            "test name": tname,
                            "performed by": widget.doctor,
                            "profession": widget.label,
                            "note" : tnote,
                            "date" : DateTime.now().year.toString() + "/" + DateTime.now().month.toString() + "/" + DateTime.now().day.toString(),
                            "result": tresult,

                          });
                          Navigator.of(context).pop();
                        },
                      )


                    ],
                  ),

                ),
              );
            });

          },) : Icon(Icons.pin, color: Colors.purple,)
        ],
      ),

      body: StreamBuilder(
          stream: Firestore.instance.collection("biodata").document(widget.id).collection("tests").orderBy("date", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(color: Colors.red,),
              );
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                test = document["test name"];
                doctorr = document["performed by"];
                date = document["date"];
                result = document["result"];
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
                          Text("Test Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(test, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                          Text("Result", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(result, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(date, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("Performed by:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(doctorr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("Profession", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(profession, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("Note", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(note, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),

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
