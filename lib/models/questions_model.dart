class Questions {
  final String category;
  final String id;
  final String title;
  final Map<String, bool> options;

  Questions({
    required this.category,
    required this.id,
    required this.title,
    required this.options,
  });

  factory Questions.fromJson(
      String category, String id, Map<String, dynamic> json) {
    return Questions(
      category: category,
      id: id,
      title: json['title'],
      options: Map<String, bool>.from(json['options']),
    );
  }
}
