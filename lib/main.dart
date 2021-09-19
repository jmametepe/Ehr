import 'package:flutter/material.dart';
import 'package:hello_world/auth.dart';
import 'package:hello_world/permissions.dart';
import 'package:provider/provider.dart';
import 'test.dart';
import 'vaccinations.dart';
import 'history.dart';
import 'treatments.dart';
import 'diagnosis.dart';
import 'profile.dart';
import 'wrapper.dart';
import 'auth.dart';
import 'user.dart';
import 'database.dart';
import 'package:hello_world/Shared/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );

  }
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);


    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid.substring(22)).userData,
      builder: (context, AsyncSnapshot snapshot) {

        if(snapshot.hasData ){
          return loading? Loading():  Scaffold(
          backgroundColor: Color.fromRGBO(229, 229, 229, 1),
          appBar: new AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            title: Text('Aeon'),
            actions: <Widget>[
              FlatButton.icon(icon: Icon(Icons.logout),
              label: Text("logout"),
                onPressed: () async{
                  setState(() => loading = true);
                dynamic result = await _auth.signOut();
                if (result == null){
                  setState(() {
                    loading = false;
                  });
                }
                },
              )
            ],
          ),
          body: Center(
            child: ListView(
              children: [
                listItem(snapshot.data.name),
                Divider(),
                Divider(),
                iconItem(),
                pin(user.uid.substring(22))
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
        );}else{
          return Scaffold(
            backgroundColor: Color.fromRGBO(229, 229, 229, 1),
            appBar: new AppBar(
              elevation: 0.0,
              backgroundColor: Colors.blue,
              title: Text('Aeon'),
              actions: <Widget>[
                FlatButton.icon(icon: Icon(Icons.logout),
                  label: Text("logout"),
                  onPressed: () async{
                    await _auth.signOut();
                  },
                )
              ],
            ),
            body: CircularProgressIndicator(),
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
                      leading: Icon(
                        Icons.home,
                        color: Colors.red,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: ListTile(
                      title: Text('Profile'),
                      leading: Icon(Icons.person, color: Colors.red),
                    ),
                  ), // account icon

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
                    },
                    child: ListTile(
                      title: Text('Tests'),
                      leading: Icon(Icons.dashboard, color: Colors.red),
                    ),
                  ), // tests icon

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Vaccinations()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Treatments()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Diagnosis()));
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
                    onTap: () {},
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(96, 206, 241, 1),
                child: Image.asset("assets/icons/try.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => History()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(173, 255, 92, 1),
                child: Image.asset("assets/icons/history.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Test()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Vaccinations()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(251, 255, 75, 1),
                child: Image.asset("assets/icons/vaccination.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Treatments()));
                },
                elevation: 2.0,
                fillColor: Color.fromRGBO(96, 206, 241, 1),
                child: Image.asset("assets/icons/treatment.png"),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Diagnosis()));
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
  }//widget listitems

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
