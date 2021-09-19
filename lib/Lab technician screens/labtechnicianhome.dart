import 'package:flutter/material.dart';
import 'package:hello_world/Doctor%20screens/creation.dart';
import 'labtechnicianhistory.dart';
import 'labtechnicianpermissions.dart';
import 'package:hello_world/auth.dart';
import 'package:hello_world/main.dart';
import 'package:hello_world/user.dart';
import 'package:provider/provider.dart';
import 'labtechnicianvaccinations.dart';
import 'labtechniciantest.dart';
import 'labtechniciantreatments.dart';
import 'labtechniciandiagnosis.dart';
import 'labtechnicianpatients.dart';
import 'package:hello_world/database.dart';
import 'labtechnicianprofile.dart';
import 'package:hello_world/Shared/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LabTechnicianHomePage extends StatefulWidget {
  @override
  _LabTechnicianHomePageState createState() => _LabTechnicianHomePageState();
}

class _LabTechnicianHomePageState extends State<LabTechnicianHomePage> {
  bool loading = false;

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading? Loading():Scaffold(
        backgroundColor: Color.fromRGBO(229, 229, 229, 1),
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('Medical Laboratory Technician'),
          actions: <Widget>[
            FlatButton.icon(icon: Icon(Icons.logout),
              label: Text("logout"),
              onPressed: () async{
                setState(() => loading = true);
                dynamic result = await _auth.signOut();
                if(result == null){
                  setState(() {
                    loading = false;
                  });
                }
              },
            )
          ],
        ),
        body: StreamBuilder<UserData>(
            stream: DatabaseService(uid: user.uid.substring(22)).userData,
            builder: (context, AsyncSnapshot snapshot) {
              if(!snapshot.hasData){
                return CircularProgressIndicator(color: Colors.red,);
              }
              return Center(
                child: ListView(
                  children: [
                    listItem(snapshot.data.name),
                    Divider(),
                    Divider(),
                    iconItem(),
                    pin(user.uid.substring(22))
                  ],
                ),
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

  Widget listItem(String message) {
    return Card(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/icons/pat.jpg"),
                fit: BoxFit.fitWidth
            )
        ),
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

  Widget iconItem() {
    return Card(
      color: Colors.white,
      child: Container(
        height: 300.00,
        child: ListView(children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianProfile()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(96, 206, 241, 1),
                child: Image.asset("assets/icons/try.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianHistory()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(173, 255, 92, 1),
                child: Image.asset("assets/icons/history.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianTest()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(166, 15, 15, 1),
                child: Image.asset("assets/icons/test.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              )
            ],
          ), //row for first set of icons

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Spacer(flex: 1),
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 20.00,
                fontWeight: FontWeight.bold,
              ),
            ), //text

            Spacer(flex: 4),

            Text(
              "History",
              style: TextStyle(
                fontSize: 20.00,
                fontWeight: FontWeight.bold,
              ),
            ), //text

            Spacer(flex: 4),

            Text(
              "Tests",
              style: TextStyle(
                fontSize: 20.00,
                fontWeight: FontWeight.bold,
              ),
            ), //text

            Spacer(flex: 1),
          ]), //Row for first set of texts

          Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianVaccinations()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(251, 255, 75, 1),
                child: Image.asset("assets/icons/vaccination.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianTreatments()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(96, 206, 241, 1),
                child: Image.asset("assets/icons/treatment.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LabTechnicianDiagnosis()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(255, 185, 185, 1),
                child: Image.asset("assets/icons/diagnosis.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              )
            ],
          ), //row for second set of icons

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Spacer(flex: 1),
            Text(
              "Vaccinations",
              style: TextStyle(
                fontSize: 20.00,
                fontWeight: FontWeight.bold,
              ),
            ), //text

            Spacer(flex: 4),

            Text(
              "Treatments",
              style: TextStyle(
                fontSize: 20.00,
                fontWeight: FontWeight.bold,
              ),
            ), //text

            Spacer(flex: 4),

            Text(
              "Diagnosis",
              style: TextStyle(
                fontSize: 20.00,
                fontWeight: FontWeight.bold,
              ),
            ), //text

            Spacer(flex: 1),
          ]),
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

  Widget pin (String text){
    return Card(
      color: Colors.white,
      child: Center(
          child: Container(
            child: Text(text, style: TextStyle(fontSize: 80, fontStyle: FontStyle.italic),),
          )),
    );
  }
}
