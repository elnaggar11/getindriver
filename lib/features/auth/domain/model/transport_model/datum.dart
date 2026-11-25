class TransportModel {
  int? id;
  String? name;
  String? icon;

  TransportModel({this.id, this.name, this.icon});

  factory TransportModel.fromJson(Map<String, dynamic> json) => TransportModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    icon: json['icon'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'icon': icon};
}
