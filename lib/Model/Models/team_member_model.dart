class TeamMemberModel {
  final String name;
  final String gitHub;
  final String linkedIn;

  const TeamMemberModel({
    required this.name,
    required this.gitHub,
    this.linkedIn = "",
  });

  static TeamMemberModel fromJson(Map<String, dynamic> json) =>
      TeamMemberModel(
        name: json['name'],
        gitHub: json['github'],
        linkedIn: json['linkedin'],
      );

  static Map<String, dynamic> toJson(TeamMemberModel model) =>
      {
        'name': model.name,
        'github': model.gitHub,
        'linkedin': model.linkedIn,
      };
}
