class Option {
  int? id;
  String? value;
  String? extraPrice;

  Option({this.id, this.value, this.extraPrice});

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json['id'] as int?,
    // The API may return these numeric fields as numbers (for example 13 and
    // 0) or as strings. Normalize both forms before building the model.
    value: json['value']?.toString(),
    extraPrice: json['extra_price']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': value,
    'extra_price': extraPrice,
  };
}
