class NoteModel {
  final String? id;
  final String title;
  final String content;
  final String? userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteModel({this.id, required this.title, required this.content, this.userId, required this.createdAt, required this.updatedAt});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      userId: json['user_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson({bool includeDates = false}) {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    if (userId != null) map['user_id'] = userId;
    if (includeDates) {
      map['created_at'] = createdAt.toIso8601String();
      map['updated_at'] = updatedAt.toIso8601String();
    }
    return map;
  }

  NoteModel copyWith({String? id, String? title, String? content, DateTime? createdAt, DateTime? updatedAt, String? userId}) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }
}
