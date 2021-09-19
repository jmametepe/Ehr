import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/database.dart';
import 'user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);
  }

  //sign anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign email
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;


      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;

    }
  }

  //register email
  Future registerWithEmailAndPassword(String email, String password, String name, String age, String gender, String dateofbirth, String phonenumber, String healthinsurancenumber, String height, String label) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create new document for user with uid
      await DatabaseService(uid: user.uid.substring(22)).updateUserData(name, age, gender, height, phonenumber, healthinsurancenumber, "your bloodtype", "your sickle cell status", "your allergies", dateofbirth, label);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;

    }
  }

  //sign out

Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }


  }

  /*Future getPatientuid(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      //FirebaseUser user = result.user;
      String userid = result.user.uid;
      result.user.uid ==
      //create new document for user with uid
      //await DatabaseService(uid: user.uid).updateUserData(name, age, gender, height, phonenumber, healthinsurancenumber, "your bloodtype", "your sickle cell status", "your allergies", dateofbirth, label);
      return userid;
    }catch(e){
      print(e.toString());
      return null;

    }
  }*/
}
