import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseImpl {
  Future<void> sendMessage(Map<String, dynamic> messageInfo) async {
    try {
      await FirebaseFirestore.instance.collection("Messages").add(messageInfo);
    } catch (e) {
      print(e.toString());
    }
  }

  /*  Future<void> logOut() async {
    try {
      await;
    } catch (e) {
      print(e.toString());
    }
  } */

  Stream<QuerySnapshot> fetchMessage() {
    try {
      return FirebaseFirestore.instance
          .collection("Messages")
          .orderBy('time')
          .snapshots();
    } catch (e) {
      print(e.toString());
      return Stream.empty();
    }
  }
}
