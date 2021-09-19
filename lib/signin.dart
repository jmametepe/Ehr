import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:hello_world/Shared/constants.dart';
import 'package:hello_world/Shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleview;
  SignIn({this.toggleview});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      appBar: AppBar(backgroundColor: Colors.blue, elevation: 0.0, title: Text('Sign in to Aeon')),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget> [

                SizedBox(height: 30),
                //form for email
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (val) => val.isEmpty? "Enter an email" : null,
                  onChanged: (val){
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
                  obscureText: true,
                  validator: (val) => val.length <6 ? "Enter a password with 6+ characters" : null,
                  onChanged: (val){
                    setState(() => password = val);

                  },
                ),

                SizedBox(height: 30),
                RaisedButton(
                  color: Colors.blue,
                  child: Text("Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    if (_formKey.currentState.validate()){
                      setState(() => loading = true);
                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = "Invalid email or password";
                          loading = false;
                        });
                        }
                      }
                    }
                    ,
                ),

                SizedBox(height: 12,),
                Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 13),
                ),

                SizedBox(height: 30),

                Text("Don't have an account?"),
                RaisedButton(
                  color: Colors.red,
                  child: Text("Sign up",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    widget.toggleview();
                  },
                ),


              ],
            ),
          ),
        )
      ),
    );
  }
}
