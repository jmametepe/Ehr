import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Shared/constants.dart';



class ViewTreatment extends StatefulWidget {
  final String doctor;
  final String label;
  final String id;

  ViewTreatment({this.label, this.doctor, this.id});

  @override
  _ViewTreatmentState createState() => _ViewTreatmentState();
}

class _ViewTreatmentState extends State<ViewTreatment> {
  static final _formKey = GlobalKey<FormState>();
  String tname = "";
  String tnote = "";
  String dosage = "";
  String duration = "";
  String reason = "";
  @override
  Widget build(BuildContext context) {
    String doctorr;
    String date;
    String state;
    String note;
    String ddosage;
    String dduration;
    String pprescription;
    String rreason;


    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        title: Text("Patient Treatments"),
        actions: [
          widget.label == "Doctor"? IconButton(icon: Icon(Icons.add, size: 40, ),onPressed: (){
            showModalBottomSheet(context: context, builder: (context){
              //final _formKey = GlobalKey<FormState>();
              //String dname ;
              //String dnote ;
              return Container(
                child: Form(
                  key: _formKey,

                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Text("Add Treatment Prescription",
                          style: TextStyle(fontSize: 18),),

                        SizedBox(height: 20,),

                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Prescription"),
                          validator: (val) => val.isEmpty? 'Please Enter a Prescription' : null,
                          onChanged: (val) {
                            setState(() => tname = val);

                          },
                        ),

                        SizedBox(height: 20,),

                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Dosage"),
                          validator: (val) => val.isEmpty? 'Please Enter a Dosage' : null,
                          onChanged: (val) {
                            setState(() => dosage = val);

                          },
                        ),

                        SizedBox(height: 20,),

                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Duration"),
                          validator: (val) => val.isEmpty? 'Please Enter a duration' : null,
                          onChanged: (val) {
                            setState(() => duration = val);

                          },
                        ),

                        SizedBox(height: 20,),

                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Treatment for"),
                          validator: (val) => val.isEmpty? 'Please Enter a Reason' : null,
                          onChanged: (val) {
                            setState(() => reason = val);

                          },
                        ),



                        SizedBox(height: 20,),


                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: "Note"),
                          //validator: (val) => val.isEmpty? 'Please Enter a NOTE' : null,
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
                                .collection("treatment")
                                .add({
                              "Doctor": widget.doctor,
                              "Note" : tnote,
                              "date" : DateTime.now().year.toString() + "/" + DateTime.now().month.toString() + "/" + DateTime.now().day.toString(),
                              "dosage": dosage,
                              "duration": duration,
                              "prescription": tname,
                              "reason": reason,
                              "state": "ongoing",

                            });
                            Navigator.of(context).pop();
                          },
                        ),


                        SizedBox(
                          height: 350,
                        ),


                      ],
                    ),
                  ),

                ),
              );
            });

          },) : Icon(Icons.pin, color: Colors.purple,)
        ],
      ),

      body: StreamBuilder(
          stream: Firestore.instance.collection("biodata").document(widget.id).collection("treatment").orderBy("date", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(color: Colors.red,),
              );
            }
            return ListView(
              children: snapshot.data.documents.map((document){
                pprescription = document["prescription"];
                ddosage = document["dosage"];
                dduration = document["duration"];
                rreason = document["reason"];
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
                          Text("Prescription", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(pprescription, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),

                          Text("Dosage", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(ddosage, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),

                          Text("Duration", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(dduration, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),

                          Text("Reason", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(rreason, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),

                          Text("Doctor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(doctorr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(date, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:<Widget> [
                              Text("State", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              widget.label == "Doctor"? IconButton(icon: Icon(Icons.edit,  size: 20,), onPressed: ()async{
                                await document.reference.updateData({"state": "Completed"});
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
