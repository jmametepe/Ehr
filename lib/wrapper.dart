//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/Doctor%20screens/doctorhome.dart';
import 'package:hello_world/Shared/loading.dart';
import 'package:hello_world/database.dart';
import 'package:hello_world/test.dart';
import 'package:hello_world/user.dart';
import 'package:hello_world/userscreens.dart';
import 'package:hello_world/vaccinations.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'authenticate.dart';
import 'user.dart';
import 'diagnosis.dart';
import 'database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';


class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


  @override
  Widget build(BuildContext context) {



    final user = Provider.of<User>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }
    else {
      return Userscreens();
    }
  }
}