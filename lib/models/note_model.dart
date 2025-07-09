class NoteModel {
  String id;
  final String title;
  final String message;
  final String uid;

  NoteModel({
    this.id = '',
    required this.title,
    required this.message,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'uid': uid,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map, [String id = '']) {
    return NoteModel(
      id: id,
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      uid: map['uid'] ?? '',
    );
  }
}
