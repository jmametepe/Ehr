import 'package:flutter/material.dart';
import 'main.dart';
import 'vaccinations.dart';
import 'history.dart';
import 'treatments.dart';
import 'diagnosis.dart';
import 'profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'permissions.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String test;
    String doctorr;
    String date;
    String result;
    String note;
    String profession;
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text('Tests'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("biodata").document(user.uid.substring(22)).collection("tests").orderBy("date", descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          return ListView(

            children: snapshot.data.documents.map((document) {
              test = document["test name"];
              doctorr = document["performed by"];
              date = document["date"];
              result = document["result"];
              note = document["note"];
              profession = document["profession"];



              return Card(
                color: Colors.white,
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width/0.8,
                    //height: MediaQuery.of(context).size.height/5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Test Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text(test, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),),
                        Text("Result", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text(result, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        Text("Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text(date, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        Text("Performed by:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text(doctorr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                        Text("Profession", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text(profession, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
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
