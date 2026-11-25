// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReviewModel {
  ReviewModel({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  final String? id;
  final String? userName;
  final int? rating;
  final String? comment;
  final String? createdAt;

  factory ReviewModel.fromMap(Map<String, dynamic> json) {
    return ReviewModel(
      id: json["id"]?.toString(),
      userName: json["user_name"],
      rating: json["rating"],
      comment: json["comment"],
      createdAt: json["created_at"],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_name': userName,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
    };
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ReviewsPagination {
  ReviewsPagination({required this.lastPage, required this.reviews});

  final int? lastPage;
  final List<ReviewModel> reviews;

  factory ReviewsPagination.fromJson(Map<String, dynamic> json) {
    return ReviewsPagination(
      lastPage: json["pagination"]?["lastPage"] ?? 1,
      reviews: json["data"] == null
          ? []
          : List<ReviewModel>.from(
              json["data"].map((x) => ReviewModel.fromMap(x)),
            ),
    );
  }
}
