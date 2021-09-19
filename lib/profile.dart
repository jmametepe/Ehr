import 'package:flutter/material.dart';
import 'package:hello_world/Shared/loading.dart';
import 'package:hello_world/edit_form.dart';
import 'test.dart';
import 'vaccinations.dart';
import 'history.dart';
import 'treatments.dart';
import 'diagnosis.dart';
import 'main.dart';
import 'package:hello_world/Shared/constants.dart';
import 'package:provider/provider.dart';
import 'user.dart';
import 'database.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    var newstring = user.uid.substring(22);
    //final userdata = Provider.of<UserData>(context);

    void _showeditpannel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
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
              backgroundColor: Colors.blue,
              title: Text('Profile'),
            ),
            body: Center(
              child: ListView(
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
                  title("Email"),
                  content('jmametepe@gmail.com'),
                  Divider(height: 10.00, thickness: 2, color: Colors.black),
                  title(userData.healthinsurancenumber),
                  content('60278924'),
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
                  //title("height"),
                  //content('userData.height'),
                  //SizedBox(height: 10,),


                  RaisedButton(
                      color: Colors.blue,
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

        }else{
          return Scaffold(
              backgroundColor: Color.fromRGBO(229, 229, 229, 1),
        appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue,
        title: Text('Profile'),

        ),
         body: Loading(),
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



}
