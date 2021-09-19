import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/user.dart';
import 'user.dart';

class DatabaseService {
final String uid;
DatabaseService({this.uid});

  // collection reference

  final CollectionReference biodataCollection = Firestore.instance.collection('biodata');

final CollectionReference treatmentCollection = Firestore.instance
.collection("biodata")
.document()
.collection("treatment");

final CollectionReference patientCollection = Firestore.instance
.collection("biodata")
.document()
.collection("patient");

Future updateUserData(String name, String age, String gender, height, String phone_number, String health_insurance, String bloodtype, String sicklecell, String allergies, String date_of_birth, String label,) async{
  return await biodataCollection.document(uid).setData({
    'name': name,
    'age' : age,
    'gender': gender,
    'height': height,
    'phone number': phone_number,
    'health insurance number': health_insurance,
    'blood type': bloodtype,
    'sickle cell status': sicklecell,
    'allergies': allergies,
    'date of birth': date_of_birth,
    'label': label,

  });
}

//update patient data
  Future updatepatientdata(String patientid,String patientname, String patientage, String patientgender, String patientdateofbirth, String patientphonenumber, String patienthealthinsurancenumber, String patientbloodtype,String patientsicklecellstatus, String patientallergies, String patientheight)async{
  return await patientCollection.document(uid).setData({
    "patient id": patientid,
    "patient name": patientname,
    "patient age": patientage,
    "patient gender": patientgender,
    "patient date of birth": patientdateofbirth,
    "patient phone number": patientphonenumber,
    "patient health insurance number": patienthealthinsurancenumber,
    "patient blood type": patientbloodtype,
    "patient sickle cell status": patientsicklecellstatus,
    "patient allergies": patientallergies,
    "patient height": patientheight
  });
  }
//UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid: uid,
        name: snapshot.data["name"],
  age: snapshot.data["age"],
  gender: snapshot.data["gender"],
  dateofbirth: snapshot.data["date of birth"],
  phonenumber: snapshot.data["phone number"],
  healthinsurancenumber: snapshot.data["health insurance number"],
  bloodtype: snapshot.data["blood type"],
  sicklecellstatus: snapshot.data["sickle cell status"],
  allergies: snapshot.data["allergies"],
    label: snapshot.data ["label"],
    height: snapshot.data["height"],


  );
  }

  //patient data from snapshot
  Patient _patientdataFromSnapshot(DocumentSnapshot snapshot){
  return Patient(
    patientid: snapshot.data["patient id"],
    patientname: snapshot.data["name"],
    patientage: snapshot.data["Age"],
    patientgender: snapshot.data["Gender"],
    patientdateofbirth: snapshot.data["Date of birth"],
    patientphonenumber: snapshot.data["Phone number"],
    patienthealthinsurancenumber: snapshot.data["Health Insurance Number"],
    patientbloodtype: snapshot.data["Blood type"],
    patientsicklecellstatus: snapshot.data["Sickle cell status"],
    patientallergies: snapshot.data["Allergies"],
    patientheight: snapshot.data["Height"],

  );
  }

//patient list from snapshot
  List<Patient> _patientlistFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((document){
      return Patient(
        patientid: document.data["patient id"] ?? "",
        patientname: document.data["name"] ?? "",
        patientage: document.data["Age"] ?? "",
        patientgender: document.data["Gender"] ?? "",
        patientdateofbirth: document.data["Date of birth"] ?? "",
        patientphonenumber: document.data["Phone number"] ?? "",
        patienthealthinsurancenumber: document.data["Health Insurance Number"] ?? "",
        patientbloodtype: document.data["Blood type"] ?? "",
        patientsicklecellstatus: document.data["Sickle cell status"] ?? "",
        patientallergies: document.data["Allergies"] ?? "",
        patientheight: document.data["Height"] ?? "",
      );
    }).toList();
  }
  
  //get patients from stream
  Stream<List<Patient>> get patient{
  return biodataCollection.document(uid.substring(22)).collection("patients").snapshots()
      .map(_patientlistFromSnapshot);
  }

  //Health officer data from snapshot
  HealthOfficer _healthOfficerFromSnapshot(DocumentSnapshot snapshot){
  return HealthOfficer(
    officerid: snapshot.data["Officer ID"],
    name: snapshot.data["Name"],
    profession: snapshot.data["Profession"],
    gender: snapshot.data["Gender"],
    phonenumber: snapshot.data["phone number"],

  );
  }

//Get user data stream
Stream <UserData> get userData {
  return biodataCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
}

// Get patient data stream

//add treatment
Future addtreatment(String patientID, String treatmentname, String dosage, String duration, String doctorname) async{
  return await treatmentCollection.add({
    "patientID": patientID,
    "treatmentname": treatmentname,
    "dosage": dosage,
    "duration" : duration,
    "doctorname": doctorname
  });
}
}