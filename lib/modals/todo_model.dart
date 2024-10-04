class Todo {
  String id, title;
  bool status;
  String dTime;

  Todo(this.id, this.title, this.status, this.dTime);

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      data['id'],
      data['title'],
      data['status'],
      data['dTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'dTime': dTime,
    };
  }
}
