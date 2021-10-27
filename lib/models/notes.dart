class Note {
  String id;
  String profileImageUrl;
  String comment;
  // String foodPictureUrl;
  String timestamp;

  Note({
    required this.id,
    required this.profileImageUrl,
    required this.comment,
    // required this.foodPictureUrl,
    required this.timestamp,
  });

  // factory Note.fromJson(Map<String, dynamic> json) {
  //   return Note(
  //     id: json['id'] ?? '',
  //     profileImageUrl: json['profileImageUrl'] ?? '',
  //     comment: json['comment'] ?? '',
  //     foodPictureUrl: json['foodPictureUrl'] ?? '',
  //     timestamp: json['timestamp'] ?? '',
  //   );
  // }
}
