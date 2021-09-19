import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Doctor%20screens/viewpatient.dart';
import 'package:hello_world/user.dart';
import 'package:provider/provider.dart';
import 'doctorprofile.dart';
import 'doctorpermissions.dart';
import 'creation.dart';
import 'package:hello_world/database.dart';
import 'package:hello_world/main.dart';
import 'doctorhistory.dart';
import 'doctortest.dart';
import 'doctorvaccinations.dart';
import 'doctortreatments.dart';
import 'doctordiagnosis.dart';






class DoctorPatients extends StatefulWidget {

  @override
  _DoctorPatientsState createState() => _DoctorPatientsState();
}

class _DoctorPatientsState extends State<DoctorPatients> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String id;
    String name;
    String age;
    String gender;
    String dateofbirth;
    String phonenumber;
    String healthinsurance;
    String bloodtype;
    String sicklecellstatus;
    String allergies;
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: new AppBar(
        backgroundColor: Colors.purple,
        title: Text("Patients"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("biodata").document(user.uid.substring(22)).collection("patients").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(color: Colors.red,),
            );
          }
          return ListView(
            children: snapshot.data.documents.map((document) {
              id = document["patient id"];
              name = document["name"];
              age = document["Age"];
              gender = document["Gender"];
              dateofbirth = document["Date of birth"];
              phonenumber = document["Phone number"];
              healthinsurance = document["Health Insurance Number"];
              bloodtype = document["Blood type"];
              sicklecellstatus = document["Sickle cell status"];
              allergies = document["Allergies"];
              return Center(
                child: Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width/0.8,
                    height: MediaQuery.of(context).size.height/5.8,
                    child: ListView(
                      children: [
                        Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        Text(name, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, fontWeight: FontWeight.w900),),
                        Text("Patient ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        Text(id, style: TextStyle( fontSize: 18),),
                        Row(
                          children: [

                            //view patient details
                            IconButton(icon: Icon(Icons.remove_red_eye_outlined), onPressed: (){
                              setState(() {
                                id = document["patient id"];
                                name = document["name"];
                                age = document["Age"];
                                gender = document["Gender"];
                                dateofbirth = document["Date of birth"];
                                phonenumber = document["Phone number"];
                                healthinsurance = document["Health Insurance Number"];
                                bloodtype = document["Blood type"];
                                sicklecellstatus = document["Sickle cell status"];
                                allergies = document["Allergies"];
                              });
                              print (id);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPatient(id: id, name: name, age: age, gender: gender, dateofbirth: dateofbirth, phonenumber: phonenumber, healthinsurancenumber: healthinsurance, bloodtype: bloodtype, sicklecellstatus: sicklecellstatus, allergies: allergies,)),);
                              return ViewPatient();


                            },),

                            //delete patient
                            IconButton( icon: Icon(Icons.delete), onPressed: ()async{
                              await Firestore.instance
                                  .collection("biodata")
                                  .document(user.uid.substring(22))
                                  .collection("patients")
                                  .document(id)
                                  .delete();
                              
                              await Firestore.instance
                              .collection("biodata")
                              .document(id)
                              .collection("Health Officers")
                              .document(user.uid.substring(22))
                              .delete();
                                  
                            },),
                          ],
                        ),

                      ],
                    ),
                  ),
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
                decoration: new BoxDecoration(color: Colors.red,),
              ),

              // body
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                },
                child: ListTile(
                  title: Text('Home'),
                  leading: Icon(
                    Icons.home,
                    color: Colors.red,
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorProfile()));
                },
                child: ListTile(
                  title: Text('Profile'),
                  leading: Icon(Icons.person, color: Colors.red),
                ),
              ), // account icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorHistory()));
                },
                child: ListTile(
                  title: Text('History'),
                  leading: Icon(
                    Icons.book,
                    color: Colors.red,
                  ),
                ),
              ), // bookings icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorTest()));
                },
                child: ListTile(
                  title: Text('Tests'),
                  leading: Icon(Icons.dashboard, color: Colors.red),
                ),
              ), // tests icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorVaccinations()));
                },
                child: ListTile(
                  title: Text('Vaccinations'),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorTreatments()));
                },
                child: ListTile(
                  title: Text('Treatments'),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDiagnosis()));
                },
                child: ListTile(
                  title: Text('Diagnosis'),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorPatients()));
                },
                child: ListTile(
                  title: Text('Patients'),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
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
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),



              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorPermissions()));
                },
                child: ListTile(
                  title: Text('Permissions'),
                  leading: Icon(
                    Icons.security,
                    color: Colors.red,
                  ),
                ),
              ), // favorites icon

              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text('Security'),
                  leading: Icon(
                    Icons.lock,
                    color: Colors.red,
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
