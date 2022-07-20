import 'package:flutter/material.dart';
import 'package:plasma/Model/APIs/Dummy/team_members_list.dart';
import 'package:plasma/Model/Models/team_member_model.dart';
import 'package:plasma/View/Mobile/member_info_screen.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class TeamMembersScreen extends StatelessWidget {
  const TeamMembersScreen({Key? key}) : super(key: key);

  static final List<TeamMemberModel> _members = teamMembersList
      .map((member) => TeamMemberModel.fromJson(member))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/logo.png',
              ),
              backgroundColor: Colors.white,
              radius: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            TranslatedTextWidget(text: 'Developers Team'),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MemberInfoScreen(memberModel: _members[index]),
            ),
          ),
          title: TranslatedTextWidget(
            text: _members[index].name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _members.length,
      ),
    );
  }
}
