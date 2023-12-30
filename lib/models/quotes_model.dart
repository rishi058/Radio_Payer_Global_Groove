class QuotesModel {
  String content;
  String author;

  QuotesModel({
    required this.content,
    required this.author,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> json) {
    return QuotesModel(
      content: json['content'] as String,
      author: json['author'] as String,
    );
  }
}
