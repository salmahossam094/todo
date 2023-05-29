class TaskModel {
  String id;
  String title;
  String des;
  int date;
  bool status;
  String userId;

  TaskModel(
      {this.id = '',
        required this.userId,
        required this.title,
        required this.des,
        required this.date,
        required this.status});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json["id"],
    title: json["title"],
    des: json["des"],
    date: json["date"],
    status: json["status"],
    userId: json['userId'],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "des": des,
      "date": date,
      "status": status,
      "userId":userId,
    };
  }
}
