import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/Shared/constants.dart';
import 'package:hello_world/Shared/loading.dart';
import 'package:hello_world/database.dart';
import 'package:hello_world/user.dart';
import 'package:provider/provider.dart';


class Edit_form extends StatefulWidget {

  @override
  _Edit_formState createState() => _Edit_formState();
}

class _Edit_formState extends State<Edit_form> {

  final _formKey = GlobalKey<FormState>();
  final List<String> gender = ["Male", "Female"];
  final List<String> bloodtype = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  final List<String> sicklecell = ["SS", "SC", "SB", "SD", "SO",];


  //Current values
  String _currentname;
  String _currentage;
  String _currentgender;
  String _currentdateofbirth;
  String _currentphonenumber;
  String _currenthealthinsurancenumber;
  String _currentbloodtype;
  String _currentsicklecellstatus;
  String _currentallergies;
  String _currentheight;
  String _currentlabe;
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid.substring(22)).userData,
      builder: (context, AsyncSnapshot snapshot) {

        if(snapshot.hasData){

          UserData userData = snapshot.data;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text("Update your profile",
                        style: TextStyle(fontSize: 18),),

                      SizedBox(height: 20,),

                      Text("Name", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),

                      TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration.copyWith(hintText: "Name"),
                        validator: (val) => val.isEmpty? 'Please Enter a name' : null,
                        onChanged: (val) => setState(() => _currentname = val),
                      ),

                      SizedBox(height: 20,),

                      /*Text("Age", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),

                      TextFormField(
                        initialValue: userData.age,
                        decoration: textInputDecoration.copyWith(hintText: "Age"),
                        validator: (val) => val.isEmpty? 'Please Enter an age' : null,
                        onChanged: (val) => setState(() => _currentage = val),
                      ),

                      SizedBox(height: 20,),
*/


                      /*Text("Date of birth", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),

                      TextFormField(
                        initialValue: userData.dateofbirth,
                        decoration: textInputDecoration.copyWith(hintText: "Date of birth"),
                        validator: (val) => val.isEmpty? 'Please Enter a date of birth' : null,
                        onChanged: (val) => setState(() => _currentdateofbirth = val),
                      ),

                      SizedBox(height: 20,),
*/




                      Text("Phone number", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),

                      TextFormField(
                        initialValue: userData.phonenumber,
                        decoration: textInputDecoration.copyWith(hintText: "Phone Number"),
                        validator: (val) => val.isEmpty? 'Please Enter a phone number' : null,
                        onChanged: (val) => setState(() => _currentphonenumber = val),
                      ),

                      SizedBox(height: 20,),


                      Text("Health Insurance Number", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),

                      TextFormField(
                        initialValue: userData.healthinsurancenumber,
                        decoration: textInputDecoration.copyWith(hintText: "NHIS"),
                        validator: (val) => val.isEmpty? 'Please Enter an NHIS number' : null,
                        onChanged: (val) => setState(() => _currenthealthinsurancenumber = val),
                      ),
                      SizedBox(height: 20,),

                      /*Text("Blood type", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      //dropdown
                      DropdownButtonFormField<String>(
                        decoration: textInputDecoration.copyWith(hintText: "Blood type"),
                        //value: _currentbloodtype?? userData.bloodtype,
                        items: bloodtype.map((bloodtype){
                          return DropdownMenuItem(
                            value: bloodtype,
                            child: Text("$bloodtype"),
                          );
                        } ).toList(),
                        onChanged: (val) => setState(() => _currentbloodtype = val),
                      ),

                      SizedBox(height: 20,),*/

                      /*Text("Sickle cell status", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),

                      DropdownButtonFormField<String>(
                        decoration: textInputDecoration.copyWith(hintText: "Sickle cell status"),
                        //value: _currentgender?? "Male",
                        items: sicklecell.map((sicklecell){
                          return DropdownMenuItem(
                            value: sicklecell,
                            child: Text("$sicklecell"),
                          );
                        } ).toList(),
                        onChanged: (val) => setState(() => _currentsicklecellstatus = val),
                      ),

                      SizedBox(height: 20,),
*/
                     /* Text("Gender", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),

                      //dropdown
                      DropdownButtonFormField<String>(
                        decoration: textInputDecoration.copyWith(hintText: userData.gender),
                        //value: _currentgender?? "Male",
                        items: gender.map((gender){
                          return DropdownMenuItem(
                            value: gender,
                            child: Text("$gender"),
                          );
                        } ).toList(),
                        onChanged: (val) => setState(() => _currentgender = val),
                      ),*/

                      SizedBox(height: 20,),


                      Text("Allergies", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),

                      TextFormField(
                        initialValue: userData.allergies,
                        decoration: textInputDecoration.copyWith(hintText: "Allergies"),
                        validator: (val) => val.isEmpty? 'Please Enter an allergy' : null,
                        onChanged: (val) => setState(() => _currentallergies = val),
                      ),

                      SizedBox(height: 20,),


                      Text("Height", style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),

                      TextFormField(
                        initialValue: userData.height,
                        decoration: textInputDecoration.copyWith(hintText: "Height in cm"),
                        //validator: (val) => val.isEmpty? 'Please Enter a height' : null,
                        onChanged: (val) => setState(() => _currentheight = val),
                      ),

                      SizedBox(height: 100,),

                      //save button
                      RaisedButton(
                          color: Colors.red,
                          child: Text("Save",
                            style: TextStyle(color: Colors.white),),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              await DatabaseService(uid: user.uid.substring(22)).updateUserData(
                                  _currentname?? userData.name,
                                  _currentage?? userData.age,
                                  _currentgender?? userData.gender,
                                  _currentheight?? userData.height,
                                  _currentphonenumber?? userData.phonenumber,
                                  _currenthealthinsurancenumber?? userData.healthinsurancenumber,
                                  _currentbloodtype?? userData.bloodtype,
                                  _currentsicklecellstatus?? userData.sicklecellstatus,
                                  _currentallergies?? userData.allergies,
                                  _currentdateofbirth?? userData.dateofbirth,
                                  userData.label?? userData.label,);

                              Navigator.pop(context);
                            }


                          }),
                    ],
                  ),
                ),
              ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );

        }


//return Container();
      }
    );
  }


}
