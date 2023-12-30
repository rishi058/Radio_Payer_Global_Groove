import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDB{
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String userName = FirebaseAuth.instance.currentUser!.displayName!;
  String userMail = FirebaseAuth.instance.currentUser!.email!;
  String userPicture = FirebaseAuth.instance.currentUser!.photoURL!;

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');
  final CollectionReference customRadioCollection = FirebaseFirestore.instance.collection('radio');

}
