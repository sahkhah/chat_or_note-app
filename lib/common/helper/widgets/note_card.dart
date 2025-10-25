import 'package:firebase_implementation/domain/notes/note_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onPressed;
  const NoteCard({super.key, required this.note, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    DateTime displayTime =
        note.updatedAt.isAfter(note.createdAt)
            ? note.updatedAt
            : note.createdAt;

    String formatDate = DateFormat('h: mma MMMM d, y').format(displayTime);

    return GestureDetector(
      onTap: onPressed,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                maxLines: 2,
                note.title,
                style: TextStyle(
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Text(formatDate, style: TextStyle(fontSize: 12),)
                ],
              ),
              Gap(10),
              Text(
                maxLines: 3,
                note.content,
                style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
