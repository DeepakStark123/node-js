class ChatModel {
  final String message;
  final String userName;
  final String clientId;
  final String? dateTime;

  ChatModel({
    required this.message,
    required this.userName,
    required this.clientId,
    this.dateTime,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['message'] ?? "",
      userName: json['username'] ?? "",
      dateTime: json['dateTime'] ?? DateTime.now().toString(),
      clientId: json['clientId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'username': userName,
      'dateTime': dateTime,
      'clientId': clientId,
    };
  }
}
