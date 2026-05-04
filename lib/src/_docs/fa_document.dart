class FaDocument {
  final String id;
  final String url;
  final String title;
  final String langCode;
  final bool published;

  FaDocument({
    required this.id,
    required this.url,
    required this.title,
    required this.langCode,
    required this.published,
  });

  factory FaDocument.fromMap(Map<String, dynamic> map) {
    return FaDocument(
      id: map['id']!.toString(),
      url: map['url']!,
      title: map['title']!,
      langCode: map['lang_code']!,
      published: map['published']!,
    );
  }
}
