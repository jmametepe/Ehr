import 'package:flutter/material.dart';
import 'nursehistory.dart';
import 'package:hello_world/main.dart';
import 'nursevaccinations.dart';
import 'nursetest.dart';
import 'nursediagnosis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/user.dart';
import 'nurseprofile.dart';
import 'nursepatients.dart';
import 'nursepermissions.dart';
import 'package:hello_world/Doctor screens/creation.dart';
import 'package:hello_world/database.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NurseTreatments extends StatefulWidget {

  @override
  _NurseTreatmentsState createState() => _NurseTreatmentsState();
}

class _NurseTreatmentsState extends State<NurseTreatments> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String doctorr;
    String date;
    String state;
    String note;
    String ddosage;
    String dduration;
    String pprescription;
    String rreason;
    return Scaffold(
        backgroundColor: Color.fromRGBO(229, 229, 229, 1),
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          title: Text('Treatments'),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection("biodata").document(user.uid.substring(22)).collection("treatment").orderBy("date", descending: true).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            Text("State", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                decoration: new BoxDecoration(color: Colors.green,),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NurseProfile()));
                },
                child: ListTile(
                  title: Text('Profile'),
                  leading: SvgPicture.asset("assets/icons/bl_user.svg",),
                ),
              ), // account icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NurseHistory()));
                },
                child: ListTile(
                    title: Text('History'),
                    leading:SvgPicture.asset("assets/icons/bl_history.svg",)
                ),
              ), // bookings icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NurseTest()));
                },
                child: ListTile(
                  title: Text('Tests'),
                  leading: SvgPicture.asset("assets/icons/bl_tests.svg",),
                ),
              ), // tests icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NurseVaccinations()));
                },
                child: ListTile(
                  title: Text('Vaccinations'),
                  leading: SvgPicture.asset("assets/icons/bl_vaccinations.svg",),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NurseTreatments()));
                },
                child: ListTile(
                  title: Text('Treatments'),
                  leading: SvgPicture.asset("assets/icons/bl_treatments.svg",),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NurseDiagnosis()));
                },
                child: ListTile(
                  title: Text('Diagnosis'),
                  leading: SvgPicture.asset("assets/icons/bl_diagnosis.svg",),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NursePatients()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NursePermissions()));
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

