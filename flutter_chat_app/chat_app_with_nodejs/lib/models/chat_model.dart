class ChatModel {
  final String message;
  final String userName;
  String? dateTime;

  ChatModel({
    required this.message,
    required this.userName,
    this.dateTime,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['message'] ?? "",
      userName: json['username'] ?? "",
      dateTime: json['dateTime'] ?? DateTime.now().toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'username': userName,
      'dateTime': dateTime,
    };
  }
}
