import 'package:flutter/material.dart';
import 'package:hello_world/main.dart';
import 'labtechnicianhistory.dart';
import 'labtechniciantest.dart';
import 'labtechniciantreatments.dart';
import 'labtechniciandiagnosis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/user.dart';
import 'labtechnicianprofile.dart';
import 'labtechnicianpatients.dart';
import 'labtechnicianpermissions.dart';
import 'package:hello_world/Doctor screens/creation.dart';
import 'package:hello_world/database.dart';
import 'package:flutter_svg/flutter_svg.dart';



class LabTechnicianVaccinations extends StatefulWidget {


  @override
  _LabTechnicianVaccinationsState createState() => _LabTechnicianVaccinationsState();
}

class _LabTechnicianVaccinationsState extends State<LabTechnicianVaccinations> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    String vaccinetype;
    String doctorr;
    String date;
    String dose;
    return Scaffold(
        backgroundColor: Color.fromRGBO(229, 229, 229, 1),
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('Vaccinations'),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection("biodata").document(user.uid.substring(22)).collection("vaccination").orderBy("date", descending: true).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data.documents.map((document) {
                  vaccinetype = document["vaccine type"];
                  doctorr = document["Vaccine officer"];
                  date = document["date"];
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
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              // heading
              new UserAccountsDrawerHeader(
                accountName: Text("Aeon"),
                //accountEmail: Text('jmametepe@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                decoration: new BoxDecoration(color: Colors.deepOrangeAccent,),
              ),

              // body
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                },
                child: ListTile(
                    title: Text('Home'),
                    leading: SvgPicture.asset("assets/icons/bl_home.svg",)
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianProfile()));
                },
                child: ListTile(
                  title: Text('Profile'),
                  leading: SvgPicture.asset("assets/icons/bl_user.svg",),
                ),
              ), // account icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianHistory()));
                },
                child: ListTile(
                    title: Text('History'),
                    leading:SvgPicture.asset("assets/icons/bl_history.svg",)
                ),
              ), // bookings icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianTest()));
                },
                child: ListTile(
                  title: Text('Tests'),
                  leading: SvgPicture.asset("assets/icons/bl_tests.svg",),
                ),
              ), // tests icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianVaccinations()));
                },
                child: ListTile(
                  title: Text('Vaccinations'),
                  leading: SvgPicture.asset("assets/icons/bl_vaccinations.svg",),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianTreatments()));
                },
                child: ListTile(
                  title: Text('Treatments'),
                  leading: SvgPicture.asset("assets/icons/bl_treatments.svg",),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianDiagnosis()));
                },
                child: ListTile(
                  title: Text('Diagnosis'),
                  leading: SvgPicture.asset("assets/icons/bl_diagnosis.svg",),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianPatients()));
                },
                child: ListTile(
                  title: Text('Patients'),
                  leading: Icon(
                    Icons.people,
                    color: Colors.black,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => permissionGenerate(context),
                  );
                },
                child: ListTile(
                  title: Text('Generate Permission'),
                  leading: Icon(
                    Icons.vpn_key,
                    color: Colors.black,
                  ),
                ),
              ),



              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianPermissions()));
                },
                child: ListTile(
                  title: Text('Permissions'),
                  leading: Icon(
                    Icons.security,
                    color: Colors.black,
                  ),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Security'),
                  leading: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                ),
              ), // favorites icon

              Divider(),

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.blue,
                  ),
                ),
              ), // settings icon

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Help'),
                  leading: Icon(
                    Icons.help,
                    color: Colors.blue,
                  ),
                ),
              ), // about icon
            ],
          ),
        )
    );
  }

  Widget permissionGenerate (BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final user = Provider.of<User>(context);
    String patientid = "";
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid.substring(22),).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return new AlertDialog(
            title: const Text('Enter Patient ID'),
            content: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Patient ID",
                    fillColor: Colors.red[10],
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (val) => val.isEmpty? "Enter an ID" : null,
                  onChanged: (val){
                    setState(() => patientid = val);
                    print (userData.name);

                  },),


              ],
            ),
            actions: <Widget>[

              new FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Creation(name: patientid, doctor: userData,)));
                  return Creation();
                  Navigator.of(context).pop();
                },
                textColor: Theme.of(context).primaryColor,
                child: const Text('Next'),
              )


            ],
          );
        }
    );
  }



}

