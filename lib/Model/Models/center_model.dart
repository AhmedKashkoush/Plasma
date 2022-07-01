class CenterModel {
  final String name;
  final String address;
  final String gov;
  final double latitude;
  final double longitude;

  const CenterModel({
    required this.name,
    required this.address,
    required this.gov,
    required this.latitude,
    required this.longitude,
  });

  static CenterModel fromJson(Map<String, dynamic> json) => CenterModel(
        name: json['name'],
        address: json['address'],
        gov: json['gov'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  static Map<String, dynamic> toJson(CenterModel model) => {
        'name': model.name,
        'address': model.address,
        'gov': model.gov,
        'latitude': model.latitude,
        'longitude': model.longitude,
      };
}
