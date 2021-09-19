import 'package:flutter/material.dart';
import 'package:hello_world/main.dart';
import 'doctortest.dart';
import 'doctorvaccinations.dart';
import 'doctortreatments.dart';
import 'doctordiagnosis.dart';
import 'doctorprofile.dart';
import 'doctorpatients.dart';
import 'doctorpermissions.dart';
import 'creation.dart';
import 'package:hello_world/database.dart';
import 'package:hello_world/user.dart';
import 'package:provider/provider.dart';

class DoctorHistory extends StatefulWidget {
  @override
  _DoctorHistoryState createState() => _DoctorHistoryState();
}

class _DoctorHistoryState extends State<DoctorHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: Text('History'),
      ),
      body: Center(
        child: ListView(
          children: [
            listItem("Genevieve Owusu-Ansah"),
            Divider(),
            Divider(),
            historyItem("2020"),
            historyItem("2019"),
            historyItem("2018"),
            historyItem("2017"),
            historyItem("2016"),
            historyItem("2015"),
          ],
        ),
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

  Widget listItem(String message) {
    return Card(
      color: Colors.white,
      child: Container(
        height: 200,
        child: Column(children: [
          Divider(),
          new CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 65,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ), //circle avatar
          Text(
            message,
            style: TextStyle(
              fontSize: 20.00,
              fontWeight: FontWeight.bold,
            ),
          ) //text
        ]),
      ), //container
    );
  } //widget listitems

  Widget historyItem(String year) {
    return Card(
      color: Colors.blue,
      child: Container(
        height: 50.00,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            year,
            style: TextStyle(
              fontSize: 18.00,
              fontWeight: FontWeight.bold,
            ),
          ), //text
        ]),
      ), //container
    );
  } //widget listitems

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
