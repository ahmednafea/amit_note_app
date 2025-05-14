class NoteModel {
  int id;
  String title;
  String description;

  NoteModel(this.id, this.title, this.description);

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "description": description};
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(map['id'], map['title'], map['description']);
  }
}
