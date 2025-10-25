import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_implementation/common/helper/widgets/note_card.dart';
import 'package:firebase_implementation/data/source/note/note_firebase_impl.dart';
import 'package:firebase_implementation/domain/notes/note_model.dart';
import 'package:firebase_implementation/presentation/add_note_screen.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final noteFirebaseImpl = NoteFirebaseImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Notes'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: noteFirebaseImpl.getNote(context),

        builder: (context, snapshot) {
          List<NoteCard> noteCard = [];

          final notes = snapshot.data!.docs;

          for (var note in notes) {
            final data = note.data() as Map<String, dynamic>;

        if (data != null) {
              Note noteObject = Note(
                content: data['description'],
                id: note.id,
                title: data['title'],
                createdAt:
                    data.containsKey('createdAt')
                        ? (data['createdAt'] as Timestamp).toDate()
                        : DateTime.now(),
                updatedAt:
                    data.containsKey('updatedAt')
                        ? (data['updatedAt'] as Timestamp).toDate()
                        : DateTime.now(),
              );
              noteCard.add(NoteCard(note: noteObject, onPressed: (){
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AddNoteScreen(
                            note: noteObject,
                          );
                        },
                      ),
                    );
              }));
            }
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: noteCard.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              return noteCard[index];
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddNoteScreen(
                  note: Note(
                    content: '',
                    title: '',
                    id: '',
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
