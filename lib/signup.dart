import 'package:flutter/material.dart';
import 'package:hello_world/Shared/loading.dart';
import 'auth.dart';
import 'package:hello_world/Shared/constants.dart';
import 'dart:io';



class Register extends StatefulWidget {

  final Function toggleview;
  Register({this.toggleview});


  @override
  _RegisterState createState() => _RegisterState();


}

class _RegisterState extends State<Register> {
  bool lloading = true;
  File _image;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String name = "";
  String age = "";
  String gender = "";
  String dateofbirth = "";
  String phonenumber = "";
  String healthinsurancenumber = "";
  String height= "";
  String label = "";
  String error = "";
  DateTime _dateTime;
  final List<String> ggender = ["Male", "Female"];
  final List<String> llable = ["Patient", "Doctor", "Nurse", "Lab Technician", "Vaccine Officer"];

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      appBar: AppBar(backgroundColor: Colors.blue,
          elevation: 0.0,
          title: Text('Sign up to Aeon'),
        actions:<Widget> [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign in"),
            onPressed: () {
              widget.toggleview();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 50,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  SizedBox(height: 30),
                  //form for email
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (val) => val.isEmpty? "Enter an email" : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),

                  SizedBox(height: 30),
                  //form for password
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    validator: (val) => val.length <6 ? "Enter a password with 6+ characters" : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),

                  SizedBox(height: 30),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Full Name"),
                    validator: (val) => val.isEmpty? "Enter your full name" : null,
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),

                  SizedBox(height: 30),

                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Colors.lightBlueAccent
                    ),
                    icon: Icon(Icons.calendar_today, color: Colors.black,),
                    label: Text("Date of birth"),
                    onPressed:(){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1520),
                        lastDate: DateTime.now(),
                      ).then((date){
                        setState(() {
                          _dateTime = date;
                          age = DateTime.now().month >= _dateTime.month? (DateTime.now().year - _dateTime.year).toString(): (DateTime.now().year - _dateTime.year - 1).toString() ;
                          dateofbirth = _dateTime.day.toString() + "/" + _dateTime.month.toString() + "/" + _dateTime.year.toString();
                        });
                      });

                    } ,
                  ),


                  Container(

                    alignment: Alignment.center,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width/0.9,
                    height: 50,
                    child: Text(_dateTime == null? "No date picked" : dateofbirth, style: TextStyle(fontSize: 30),),
                  ),

                  SizedBox(height: 30,),

                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width/0.9,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                    height: 50,
                    child: Text("Age:  " + age, style: TextStyle(fontSize: 20),),
                  ),

                  SizedBox(height: 30,),


                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration.copyWith(hintText: "Gender"),
                    items: ggender.map((ggender){
                      return DropdownMenuItem(
                        value: ggender,
                        child: Text("$ggender"),
                      );
                    } ).toList(),
                    onChanged: (val) => setState(() => gender = val),
                  ),



                  SizedBox(height: 30),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "phonenumber"),
                    validator: (val) => val.isEmpty? "Enter your phone number" : null,
                    onChanged: (val) {
                      setState(() => phonenumber = val);
                    },
                  ),

                  SizedBox(height: 30),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Health Insurance Number"),
                    validator: (val) => val.isEmpty? "Enter a health insurance number" : null,
                    onChanged: (val) {
                      setState(() => healthinsurancenumber = val);
                    },
                  ),

                  SizedBox(height: 30),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "height"),
                    validator: (val) => val.isEmpty? "Enter your height" : null,
                    onChanged: (val) {
                      setState(() => height = val);
                    },
                  ),

                  SizedBox(height: 30),

                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration.copyWith(hintText: "Register as a"),
                    items: llable.map((llable){
                      return DropdownMenuItem(
                        value: llable,
                        child: Text("$llable"),
                      );
                    } ).toList(),
                    onChanged: (val) => setState(() => label = val),
                  ),

                  SizedBox(height: 30),


                  SizedBox(height: 30),


                  RaisedButton(
                    color: Colors.blue,
                    child: Text("Register",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, age, gender, dateofbirth, phonenumber, healthinsurancenumber, height, label );
                        if(result == null){
                          setState(() {
                            error = "Error registering";
                            loading = false;
                          });
                        }
                      }
                    },
                  ),

                  SizedBox(height: 12,),
                  Text(error,
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  )

                ],
              ),
            ),
          )
      ),
    );
  }
}



