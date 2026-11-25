class TermsModel {
  final int? id;
  final String? title;
  final String? slug;
  final String? content;

  const TermsModel({this.id, this.title, this.slug, this.content});

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}'),
      title: json['title']?.toString(),
      slug: json['slug']?.toString(),
      content: json['content']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'slug': slug, 'content': content};
  }
}
