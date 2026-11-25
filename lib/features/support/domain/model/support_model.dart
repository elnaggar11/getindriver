class SupportModel {
  final int? id;
  final String? title;
  final String? description;
  final String? phoneNumber;

  SupportModel({this.id, this.title, this.description, this.phoneNumber});

  factory SupportModel.fromJson(Map<String, dynamic> json) {
    final rawPhone = json['phone_number']?.toString().trim();
    return SupportModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}'),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      phoneNumber: (rawPhone == null || rawPhone.isEmpty) ? null : rawPhone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'phone_number': phoneNumber,
    };
  }
}
