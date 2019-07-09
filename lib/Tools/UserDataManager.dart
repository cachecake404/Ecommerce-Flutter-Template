import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDataManager {
  FirebaseUser user;
  UserDataManager(this.user);

  Future<void> postData(Map<String, dynamic> m) async {
    final DatabaseReference db = FirebaseDatabase.instance.reference();
    await db.child("users").child(user.uid).set(m);
    print("DONE POSTING DATA");
  }

  Future<Map<String, dynamic>> getData() async {
    final DatabaseReference db = FirebaseDatabase.instance.reference();
    DataSnapshot dataVal = await db.child("users").child(user.uid).once();
    if(dataVal.value!=null)
    {
      return Map<String,dynamic>.from(dataVal.value);
    }
    return dataVal.value;
  }

  // After calling updateData must call Provider<DataTracker> autoSetData function to reflect changes on UI
  Future<void> updateData(Map<String, dynamic> m) async {
    final DatabaseReference db = FirebaseDatabase.instance.reference();
    await db.child("users").child(user.uid).update(m);
  }
}
