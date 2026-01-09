import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseClient {
  FirebaseClient(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> userCollection(
    String uid,
    String name,
  ) {
    return _firestore.collection('users').doc(uid).collection(name);
  }

  DocumentReference<Map<String, dynamic>> userDoc(String uid) {
    return _firestore.collection('users').doc(uid);
  }
}
