import 'package:flutter/material.dart';
import 'package:hello_world/Lab%20technician%20screens/labtechnicianhome.dart';
import 'package:hello_world/Nurse%20screens/nursehome.dart';
import 'package:hello_world/Vaccine%20officer%20screens/vaccineofficerhome.dart';
import 'wrapper.dart';
import 'user.dart';
import 'database.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/Doctor screens/doctorhome.dart';
import 'main.dart';

class Userscreens extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid.substring(22),).userData,
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.data.label == 'Doctor'){
            return DoctorHomePage();
          }else if(snapshot.hasData && snapshot.data.label == 'Nurse'){
            return NurseHomePage();
          }else if (snapshot.hasData && snapshot.data.label == 'Lab Technician'){
            return LabTechnicianHomePage();
          }else if (snapshot.hasData && snapshot.data.label == "Vaccine Officer"){
            return VaccineOfficerHomePage();
          }
          return HomePage();

        }
    );
  }
}
