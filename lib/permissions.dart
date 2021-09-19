import 'package:flutter/material.dart';
import 'main.dart';
import 'test.dart';
import 'history.dart';
import 'treatments.dart';
import 'diagnosis.dart';
import 'profile.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';
import 'vaccinations.dart';
import 'package:flutter_svg/flutter_svg.dart';



class Permissions extends StatefulWidget {

  @override
  _PermissionsState createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String id;
    String name;
    String profession;
    String gender;
    String phonenumber;
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text('Permissions'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("biodata").document(user.uid.substring(22)).collection("Health Officers").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.documents.map((document) {
              id = document["Officer ID"];
              name = document["Name"];
              gender = document["Gender"];
              phonenumber = document["phone number"];
              profession = document["Profession"];

              return Center(
                child: Card(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width/0.8,
                    height: MediaQuery.of(context).size.height/3.5,
                    child: ListView(
                      children: [
                        Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        Text(name, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18, fontWeight: FontWeight.w900),),
                        Text("Profession", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        Text(profession, style: TextStyle( fontSize: 18),),
                        Text("Gender", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        Text(gender, style: TextStyle( fontSize: 18),),
                        Text("Phone number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        Text(phonenumber, style: TextStyle( fontSize: 18),),
                            //delete Health Officer
                            IconButton( icon: Icon(Icons.delete), onPressed: ()async{
                              await Firestore.instance
                                  .collection("biodata")
                                  .document(user.uid.substring(22))
                                  .collection("Health Officers")
                                  .document(id)
                                  .delete();

                              await Firestore.instance
                                  .collection("biodata")
                                  .document(id)
                                  .collection("patients")
                                  .document(user.uid.substring(22))
                                  .delete();

                            },),


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
              accountName: Text('Joshua Mawuli'),
              accountEmail: Text('jmametepe@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.blue),
            ),

            // body
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: ListTile(
                  title: Text('Home'),
                  leading:SvgPicture.asset("assets/icons/bl_home.svg",)
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
              },
              child: ListTile(
                title: Text('Profile'),
                leading: SvgPicture.asset("assets/icons/bl_user.svg",),
              ),
            ), // account icon

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
              },
              child: ListTile(
                  title: Text('History'),
                  leading:SvgPicture.asset("assets/icons/bl_history.svg",)
              ),
            ), // bookings icon

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
              },
              child: ListTile(
                title: Text('Tests'),
                leading: SvgPicture.asset("assets/icons/bl_tests.svg",),
              ),
            ), // tests icon

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Vaccinations()));
              },
              child: ListTile(
                title: Text('Vaccinations'),
                leading: SvgPicture.asset("assets/icons/bl_vaccinations.svg",),
              ),
            ), // favorites icon

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Treatments()));
              },
              child: ListTile(
                title: Text('Treatments'),
                leading: SvgPicture.asset("assets/icons/bl_treatments.svg",),
              ),
            ), // favorites icon

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Diagnosis()));
              },
              child: ListTile(
                title: Text('Diagnosis'),
                leading: SvgPicture.asset("assets/icons/bl_diagnosis.svg",),
              ),
            ), // favorites icon

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Permissions()));
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
      ),
    );
  }
}
