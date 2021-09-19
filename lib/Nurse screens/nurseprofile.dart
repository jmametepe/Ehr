import 'package:flutter/material.dart';
import 'nursepatients.dart';
import 'package:hello_world/edit_form.dart';
import 'nursetest.dart';
import 'nursevaccinations.dart';
import 'nursehistory.dart';
import 'nursetreatments.dart';
import 'nursediagnosis.dart';
import 'package:hello_world/main.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/user.dart';
import 'package:hello_world/database.dart';
import 'package:hello_world/Doctor screens/creation.dart';
import 'nursepermissions.dart';
import 'package:flutter_svg/flutter_svg.dart';


class NurseProfile extends StatefulWidget {
  @override
  _NurseProfileState createState() => _NurseProfileState();
}

class _NurseProfileState extends State<NurseProfile> {


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    var newstring = user.uid.substring(22);
    //final userdata = Provider.of<UserData>(context);

    void _showeditpannel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          //padding: EdgeInsets.all(10),
          child: Edit_form(),
        );
      });
    }
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: newstring).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData){
            UserData userData = snapshot.data;
            print (newstring);
            return Scaffold(
                backgroundColor: Color.fromRGBO(229, 229, 229, 1),
                appBar: new AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.green,
                  title: Text('Profile'),
                ),
                body: Center(
                  child: ListView(
                    padding: EdgeInsets.all(5),
                    children: [
                      listItem(userData.name),
                      Divider(),
                      Divider(),
                      title("Name"),
                      content(userData.name),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("Age"),
                      content(userData.age),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("Gender"),
                      content(userData.gender),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("Date of birth"),
                      content(userData.dateofbirth),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("Phone Number"),
                      content(userData.phonenumber),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("Health Insurance Number"),
                      content(userData.healthinsurancenumber),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("Blood type"),
                      content(userData.bloodtype),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("Sickle Cell Status"),
                      content(userData.sicklecellstatus),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("Outlying Health condition"),
                      content('none'),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("Allergies"),
                      content(userData.allergies),
                      Divider(height: 10.00, thickness: 2, color: Colors.black),
                      title("height"),
                      content(userData.height),
                      SizedBox(height: 10,),


                      RaisedButton(
                          color: Colors.green,
                          child: Text("Edit",
                            style: TextStyle(color: Colors.white),),
                          onPressed: ()=> _showeditpannel())
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

          }else{
            return Scaffold(
              backgroundColor: Color.fromRGBO(229, 229, 229, 1),
              appBar: new AppBar(
                elevation: 0.0,
                backgroundColor: Colors.blue,
                title: Text('Profile'),

              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),

            );

          }


        }
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

  Widget title(String hedaer) {
    return Text(
      hedaer,
      style: TextStyle(
        fontSize: 18.00,
        fontWeight: FontWeight.bold,
      ),
    ); //text,
  } //widget title

  Widget content(String detail) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        detail,
        style: TextStyle(
          fontSize: 18.00,
          fontWeight: FontWeight.bold,
        ),
      ), //text
    ]);
  } //widget content


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
