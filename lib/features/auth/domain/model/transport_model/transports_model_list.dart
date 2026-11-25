import 'datum.dart';

class TransportsModelList {
  bool? status;
  String? message;
  List<TransportModel>? transports;

  TransportsModelList({this.status, this.message, this.transports});

  factory TransportsModelList.fromJson(Map<String, dynamic> json) {
    return TransportsModelList(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      transports: (json['data'] as List<dynamic>?)
          ?.map((e) => TransportModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': transports?.map((e) => e.toJson()).toList(),
  };
}
