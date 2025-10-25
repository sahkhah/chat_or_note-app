import 'package:firebase_implementation/data/source/note/note_firebase_impl.dart';
import 'package:firebase_implementation/domain/notes/note_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddNoteScreen extends StatefulWidget {
  final Note note;
  const AddNoteScreen({super.key, required this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  late Note note;
  String title = '';
  String content = '';

  @override
  void initState() {
    note = widget.note;
    title = note.title;
    content = note.content;
    titleController = TextEditingController(text: title);
    descriptionController = TextEditingController(text: content);
    super.initState();
  }

  final noteFirebaseImpl = NoteFirebaseImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: BackButton(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  Text(
                    note.id.isEmpty ? 'Add Note' : 'Edit Note',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            saveNotes();
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.save),
                        ),
                        if (note.id.isNotEmpty)
                          IconButton(
                            onPressed: () {
                              delete(note.id);
                              Navigator.of(context).pop();
                            },

                            icon: Icon(Icons.delete),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter the note title',
                  border: InputBorder.none,
                ),
                controller: titleController,
              ),
              Gap(20),
              Expanded(
                child: TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter the note description',
                    border: InputBorder.none,
                  ),
                  controller: descriptionController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  delete(String id) {
    noteFirebaseImpl.deleteNote(id);
  }

  saveNotes() async {
    DateTime now = DateTime.now();
    final noteInfo = {
      'title': titleController.text,
      'description': descriptionController.text,
      'createdAt': now,
    };
    if (note.id.isEmpty) {
      noteFirebaseImpl.addNote(noteInfo);
    } else {
      final noteUpdateInfo = {
        'title': titleController.text,
        'description': descriptionController.text,
        'updateddAt': now,
      };
      noteFirebaseImpl.updateNote(noteUpdateInfo, note.id);
    }
  }
}
