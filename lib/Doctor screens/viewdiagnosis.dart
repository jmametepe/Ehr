import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Shared/constants.dart';



class ViewDiagnosis extends StatefulWidget {
  final String doctor;
  final String label;
  final String id;

  ViewDiagnosis({this.label, this.doctor, this.id});

  @override
  _ViewDiagnosisState createState() => _ViewDiagnosisState();
}

class _ViewDiagnosisState extends State<ViewDiagnosis> {
  static final _formKey = GlobalKey<FormState>();
  String dname = "";
  String dnote = "";
  @override
  Widget build(BuildContext context) {
    String diagnosis;
    String doctorr;
    String date;
    String state;
    String note;

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        title: Text("Patient Diagnosis"),
        actions: [
          widget.label == "Doctor"? IconButton(icon: Icon(Icons.add, size: 40, ),onPressed: (){
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
                        Text("Add Diagnosis",
                          style: TextStyle(fontSize: 18),),

                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Diagnosis"),
                          validator: (val) => val.isEmpty? 'Please Enter a Diagnosis' : null,
                          onChanged: (val) {
                            setState(() => dname = val);

                          },
                        ),

                        SizedBox(height: 20,),


                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Note"),
                          //validator: (val) => val.isEmpty? 'Please Enter a NOTE' : null,
                          onChanged: (val) => setState(() {
                            dnote = val;
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
                                .collection("diagnosis")
                                .add({
                              "Doctor": widget.doctor,
                              "Note" : dnote,
                              "date" : DateTime.now().year.toString() + "/" + DateTime.now().month.toString() + "/" + DateTime.now().day.toString(),
                              "diagnosis": dname,
                              "state": "ongoing",

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
          stream: Firestore.instance.collection("biodata").document(widget.id).collection("diagnosis").orderBy("date", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(color: Colors.red,),
              );
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                diagnosis = document["diagnosis"];
                doctorr = document["Doctor"];
                date = document["date"];
                state = document["state"];
                note = document["Note"];



                return Card(
                  color: Colors.white,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width/0.8,
                        //height: MediaQuery.of(context).size.height/5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Diagnosis", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text(diagnosis, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                            Text("Doctor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text(doctorr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                            Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text(date, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:<Widget> [
                                Text("State", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                widget.label == "Doctor"? IconButton(icon: Icon(Icons.edit,  size: 20,), onPressed: ()async{
                                  await document.reference.updateData({"state": "cured"});
                                },) : Icon(Icons.pin, color: Colors.white,)
                              ],
                            ),

                            Text(state, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
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
