enum DonorType {
  accepted,
  delayed,
  excluded,
}

class DonorTypeModel {
  final DonorType? type;
  final DateTime? delayTime;

  DonorTypeModel({required this.type, this.delayTime});

  static DonorTypeModel fromJson(Map<String, dynamic> json) => DonorTypeModel(
        type: json["type"],
        delayTime: json["delay_time"],
      );

  static Map<String, dynamic> toJson(DonorTypeModel model) => <String, dynamic>{
        'type': model.type,
        'delay_time': model.delayTime,
      };
}
