import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Shared/constants.dart';



class ViewVaccination extends StatefulWidget {
  final String doctor;
  final String label;
  final String id;

  ViewVaccination({this.label, this.doctor, this.id});

  @override
  _ViewVaccinationState createState() => _ViewVaccinationState();
}

class _ViewVaccinationState extends State<ViewVaccination> {
  static final _formKey = GlobalKey<FormState>();
  String vname = "";
  String vdose = "";
  @override
  Widget build(BuildContext context) {
    String vaccinetype;
    String doctorr;
    String date;
    String dose;
    //String note;

    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        title: Text("Patient Vaccinations"),
        actions: [
          widget.label == "Vaccine Officer"? IconButton(icon: Icon(Icons.add, size: 40, ),onPressed: (){
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
                      Text("Add Vaccination",
                        style: TextStyle(fontSize: 18),),

                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Vaccine type"),
                        validator: (val) => val.isEmpty? 'Please Enter a Vaccine type' : null,
                        onChanged: (val) {
                          setState(() => vname = val);

                        },
                      ),

                      SizedBox(height: 20,),


                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: "Dose"),
                        validator: (val) => val.isEmpty? 'Please Enter a Dose' : null,
                        onChanged: (val) => setState(() {
                          vdose = val;
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
                              .collection("vaccination")
                              .add({
                            "Vaccine officer": widget.doctor,
                            "dose" : vdose,
                            "date" : DateTime.now().year.toString() + "/" + DateTime.now().month.toString() + "/" + DateTime.now().day.toString(),
                            "vaccine type": vname,
                            //"state": "ongoing",

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
          stream: Firestore.instance.collection("biodata").document(widget.id).collection("vaccination").orderBy("date", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(color: Colors.red,),
              );
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                vaccinetype = document["vaccine type"];
                doctorr = document["Vaccine officer"];
                date = document["date"];
                //state = document["state"];
                dose = document["dose"];



                return Card(
                  color: Colors.white,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width/0.8,
                      //height: MediaQuery.of(context).size.height/5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Vaccine type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(vaccinetype, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                          Text("Vaccine officer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(doctorr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(date, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                          Text("Dose", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text(dose, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
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
