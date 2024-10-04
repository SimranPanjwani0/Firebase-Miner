class Chat {
  String msg, type, status;
  DateTime time;

  Chat(
    this.time,
    this.msg,
    this.type,
    this.status,
  );

  factory Chat.fromJson(Map data) => Chat(
        DateTime.fromMillisecondsSinceEpoch(int.parse(data['time'])),
        data['msg'],
        data['type'],
        data['status'],
      );

  Map<String, dynamic> get toJson => {
        'time': time.millisecondsSinceEpoch.toString(),
        'msg': msg,
        'type': type,
        'status': status,
      };
}
