import 'package:flutter/material.dart';
import 'main.dart';
import 'vaccinations.dart';
import 'test.dart';
import 'treatments.dart';
import 'diagnosis.dart';
import 'profile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'permissions.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
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
}
