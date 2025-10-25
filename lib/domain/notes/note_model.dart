class Note {
  String id;
   String title;
   String content;
  final DateTime createdAt;
  final DateTime updatedAt;

   Note({
    required this.content,
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });
}
