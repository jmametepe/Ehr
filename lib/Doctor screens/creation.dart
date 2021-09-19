import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/main.dart';
import 'package:hello_world/user.dart';
import 'doctorhome.dart';
import 'package:hello_world/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Creation extends StatelessWidget {
  final String name;
  final UserData doctor;


  Creation({this.name, this.doctor});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: name).userData,
      builder: (context, AsyncSnapshot) {
        if(AsyncSnapshot.hasData)
        {UserData patient = AsyncSnapshot.data;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: new AppBar(
            elevation: 0.0,
            backgroundColor: Colors.black,
            title: Text(name, style: TextStyle(color: Colors.white),),
          ),
          
          body: Center(
            child: ListView(
              padding: EdgeInsets.all(5),
              children: [
                SizedBox(height: 20,),
                Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(patient.name, style: TextStyle(fontSize: 18),),
                SizedBox(height: 30,),
                Text("Age", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(patient.age, style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                Text("Gender", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(patient.gender, style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                Text("Date of Birth", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(patient.dateofbirth, style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                Text("Phone number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(patient.phonenumber, style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                Text("Health Insurance Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(patient.healthinsurancenumber, style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                Text("Blood Type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(patient.bloodtype, style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                Text("Sickle cell status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(patient.sicklecellstatus, style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                Text("Allergies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Text(patient.allergies, style: TextStyle(fontSize: 18),),
                SizedBox(height: 20,),
                RaisedButton(
                  color: Colors.blue,
                  child: Text("Verify"),
                    onPressed: () async{
                    print (doctor.uid);
                    await Firestore
                        .instance
                        .collection('biodata')
                        .document(doctor.uid)
                        .collection(
                        "patients").document(patient.uid)
                        .setData({
                      "patient id": patient.uid,
                      "name": patient.name,
                      "Age": patient.age,
                      "Gender": patient.gender,
                      "Date of birth": patient.dateofbirth,
                      "Phone number": patient.phonenumber,
                      "Health Insurance Number": patient.healthinsurancenumber,
                      "Blood type": patient.bloodtype,
                      "Sickle cell status": patient.sicklecellstatus,
                      "Allergies": patient.allergies,
                      "Height": patient.height,
                      //add your data that you want to upload
                    });

                    await Firestore.instance
                    .collection("biodata")
                    .document(patient.uid)
                    .collection("Health Officers")
                    .document(doctor.uid).setData({
                      "Officer ID": doctor.uid,
                      "Name": doctor.name,
                      "Profession": doctor.label,
                      "Gender": doctor.gender,
                      "phone number": doctor.phonenumber,

                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                    })

              ],
            ),
          ),
        );}else{
          return Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.black,
              title: Text(name, style: TextStyle(color: Colors.white),),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Unable to find Patient", style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                  Text("Please Check the ID again", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                ],
              ),
            ),
          );
        }
      }
    );
  }

}
