

import 'package:flutter/material.dart';
import 'package:hello_world/Doctor%20screens/labreport.dart';
import 'package:hello_world/Doctor%20screens/viewdiagnosis.dart';
import 'package:hello_world/Doctor%20screens/viewimages.dart';
import 'package:hello_world/Doctor%20screens/viewtest.dart';
import 'package:hello_world/Doctor%20screens/viewtreatment.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/database.dart';
import 'package:hello_world/Doctor%20screens/viewvaccination.dart';
import 'package:hello_world/Shared/constants.dart';



class ViewPatient extends StatefulWidget {
  final String id;
  final String name;
  final String age;
  final String gender;
  final String dateofbirth;
  final String phonenumber;
  final String healthinsurancenumber;
  final String bloodtype;
  final String sicklecellstatus;
  final String allergies;

  ViewPatient({this.id, this.name, this.age,this.gender, this.dateofbirth, this.phonenumber, this.healthinsurancenumber, this.bloodtype, this.sicklecellstatus, this.allergies});

  @override
  _ViewPatientState createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatient> {
  final _formKey = GlobalKey<FormState>();
  final List<String> bbloodtype = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  final List<String> ssicklecell = ["AA", "AS", "SS", "AC", "CC","SC"];
  
 String _currentbloodtype;
 String _currentsicklecellstatus;
  @override
  Widget build(BuildContext context) {
    String doctor = "";
    final user = Provider.of<User>(context);
    return Scaffold(

      appBar: new AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.name),
      ),

      body: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid.substring(22),).userData,
        builder: (context, AsyncSnapshot snapshot) {
          UserData userData = snapshot.data;
          doctor = userData.name;
          String label = userData.label;
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          print (doctor);
          return Center(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(widget.name, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                Divider(),
                Text("Age", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(widget.age, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                Divider(),
                Text("Gender", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(widget.gender, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                Divider(),
                Text("Date of birth", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(widget.dateofbirth, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                Divider(),
                Text("Phone number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(widget.phonenumber, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                Divider(),
                Text("Health Insurance Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(widget.healthinsurancenumber, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                Divider(),
                Text("Blood Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

                //Lab technician change blood type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.bloodtype, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                    label == "Lab Technician"? IconButton(icon: Icon(Icons.edit),onPressed: (){
                      showModalBottomSheet(context: context, builder: (context){
                        return Container(
                          child: Form(
                            key: _formKey,
                            
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Change Patient Bloodtype", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 20,),

                                  DropdownButtonFormField<String>(
                                    decoration: textInputDecoration.copyWith(hintText: widget.bloodtype),
                                    items: bbloodtype.map((bbloodtype){
                                      return DropdownMenuItem(
                                        value: bbloodtype,
                                        child: Text("$bbloodtype"),
                                      );
                                    } ).toList(),
                                    onChanged: (val) => setState(() => _currentbloodtype = val),
                                  ),

                                  SizedBox(height: 20,),

                                  RaisedButton(color: Colors.red,
                                    child: Text("Change"),
                                    onPressed: ()async{
                                    await Firestore.instance
                                        .collection("biodata")
                                        .document(widget.id)
                                        .updateData({"blood type": _currentbloodtype});
                                    
                                    await Firestore.instance
                                    .collection("biodata")
                                    .document(user.uid.substring(22))
                                    .collection("patients")
                                    .document(widget.id)
                                    .updateData({"Blood type": _currentbloodtype});

                                    Navigator.pop(context);

                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },) : Icon(Icons.pin, color: Colors.white,)
                  ],
                ),
                Divider(),
                Text("Sickle Cell Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),


                //Lab technician change sickle cell status

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.sicklecellstatus, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),

                    label == "Lab Technician"? IconButton(icon: Icon(Icons.edit),onPressed: (){
                      showModalBottomSheet(context: context, builder: (context){
                        return Container(
                          child: Form(
                            key: _formKey,

                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Change Patient Sickle Cell Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 20,),

                                  DropdownButtonFormField<String>(
                                    decoration: textInputDecoration.copyWith(hintText: widget.sicklecellstatus),
                                    items: ssicklecell.map((ssicklecell){
                                      return DropdownMenuItem(
                                        value: ssicklecell,
                                        child: Text("$ssicklecell"),
                                      );
                                    } ).toList(),
                                    onChanged: (val) => setState(() => _currentsicklecellstatus = val),
                                  ),

                                  SizedBox(height: 20,),

                                  RaisedButton(color: Colors.red,
                                    child: Text("Change"),
                                    onPressed: ()async{
                                      await Firestore.instance
                                          .collection("biodata")
                                          .document(widget.id)
                                          .updateData({"sickle cell status": _currentsicklecellstatus});

                                      await Firestore.instance
                                          .collection("biodata")
                                          .document(user.uid.substring(22))
                                          .collection("patients")
                                          .document(widget.id)
                                          .updateData({"Sickle cell status": _currentsicklecellstatus});

                                      Navigator.pop(context);

                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },) : Icon(Icons.pin, color: Colors.white,)
                  ],
                ),
                Divider(),
                Text("Allergies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(widget.allergies, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),),
                Divider(),
                RaisedButton(
                      color: Colors.purple,
                      child: Text("Diagnosis", style: TextStyle(color: Colors.white, fontSize: 20),),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDiagnosis(label: label, doctor: doctor, id: widget.id,)));
                        return ViewDiagnosis();

                      },
                    ),


                RaisedButton(
                  color: Colors.purple,
                  child: Text("Treatments", style: TextStyle(color: Colors.white, fontSize: 20),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTreatment(label: label, doctor: doctor, id: widget.id,)));
                    return ViewTreatment();
                  },
                ),


                RaisedButton(
                  color: Colors.purple,
                  child: Text("Tests", style: TextStyle(color: Colors.white, fontSize: 20),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTest(label: label, doctor: doctor, id: widget.id,)));
                    return ViewTest();
                  },
                ),


                RaisedButton(
                  color: Colors.purple,
                  child: Text("Vaccinations", style: TextStyle(color: Colors.white, fontSize: 20),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewVaccination(label: label, doctor: doctor, id: widget.id,)));
                    return ViewVaccination();
                  },
                ),

                RaisedButton(
                  color: Colors.purple,
                  child: Text("Images", style: TextStyle(color: Colors.white, fontSize: 20),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImages(label: label, doctor: doctor, id: widget.id,)));
                    return ViewImages();
                  },
                ),

                RaisedButton(
                  color: Colors.purple,
                  child: Text("Lab Reports", style: TextStyle(color: Colors.white, fontSize: 20),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LabReport(label: label, doctor: doctor, id: widget.id,)));
                    return LabReport();
                  },
                ),


              ],
            ),
          );
        }
      ),

    );
  }
}
