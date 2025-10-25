import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteFirebaseImpl {
  Stream<QuerySnapshot> getNote(BuildContext context) {
    try {
      return FirebaseFirestore.instance.collection('Notes').snapshots();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return Stream.empty();
    }
  }

  void deleteNote(String id) async {
    await FirebaseFirestore.instance.collection('Notes').doc(id).delete();
  }

  void addNote(Map<String, dynamic> noteInfo) async {
    await FirebaseFirestore.instance.collection('Notes').add(noteInfo);
  }
  
  void updateNote(Map<String, dynamic> noteInfo, String id) async {
    await FirebaseFirestore.instance.collection('Notes').doc(id).update(noteInfo);
  }
}
