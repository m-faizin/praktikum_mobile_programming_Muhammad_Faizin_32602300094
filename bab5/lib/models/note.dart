class Note {
  final String id;
  String title;
  String content;
  DateTime createdAt;
  Note({required this.id, required this.title, required this.content, DateTime? createdAt})
      : createdAt = createdAt ?? DateTime.now();
  Note copyWith({String? id, String? title, String? content, DateTime? createdAt}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  String get formattedDate {
    final d = createdAt;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }
}
