import 'package:plasma/Model/Models/donor_type_model.dart';
import 'package:plasma/Model/Models/notifications_model.dart';
import 'package:plasma/Model/Models/reservation_model.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final String nationalId;
  final String? image;
  final String? bloodType;
  final Map<String, dynamic>? notifications;
  final Map<String, dynamic>? reservation;
  final Map<String, dynamic>? donorTypeModel;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
    required this.nationalId,
    this.image,
    this.bloodType,
    this.notifications,
    this.reservation,
    this.donorTypeModel,
  });

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        nationalId: json["national_id"],
        image: json["image"] ?? '',
        bloodType: json["blood_type"]?? '',
        notifications: json["notifications"],
        reservation: json["reservation"],
        donorTypeModel: json["donor_type"],
      );

  static Map<String, dynamic> toJson(UserModel model) => <String, dynamic>{
        'first_name': model.firstName,
        'last_name': model.lastName,
        'phone': model.phone,
        'email': model.email,
        'password': model.password,
        'national_id': model.nationalId,
        'image': model.image ?? '',
        'blood_type': model.bloodType ?? '',
        'notifications': model.notifications!,
        'reservation': model.reservation!,
        'donor_type': model.donorTypeModel!,
      };
}
