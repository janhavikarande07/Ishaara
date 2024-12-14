import 'package:cloud_firestore/cloud_firestore.dart';

createUser(uid, data) async {
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .set(data);
}

updateUser(uid, data) async {
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .update(data);
}