class User {
  final String uid;


  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String age;
  final String gender;
  final String dateofbirth;
  final String phonenumber;
  final String healthinsurancenumber;
  final String bloodtype;
  final String sicklecellstatus;
  final String allergies;
  final String height;
  final String label;

  UserData ({this.uid, this.name, this.age, this.gender, this.dateofbirth, this.phonenumber, this.healthinsurancenumber, this.bloodtype, this.sicklecellstatus, this.allergies, this.height, this.label});
}

class Treatment{
  final String patientID;
  final String treatmentname;
  final String dosage;
  final String duration;
  final String doctorname;

  Treatment({this.patientID, this.treatmentname, this.dosage, this.duration, this.doctorname});

}

class Patient{
  final String patientid;
  final String patientname;
  final String patientage;
  final String patientgender;
  final String patientdateofbirth;
  final String patientphonenumber;
  final String patienthealthinsurancenumber;
  final String patientbloodtype;
  final String patientsicklecellstatus;
  final String patientallergies;
  final String patientheight;

  Patient({this.patientid, this.patientname, this.patientage, this.patientgender, this.patientdateofbirth, this.patientphonenumber, this.patienthealthinsurancenumber, this.patientbloodtype, this.patientsicklecellstatus,this.patientallergies, this.patientheight});

}

class HealthOfficer{
  final String officerid;
  final String name;
  final String profession;
  final String gender;
  final String phonenumber;

  HealthOfficer({this.officerid, this.name, this.profession, this.gender, this.phonenumber});
}