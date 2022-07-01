import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plasma/Model/APIs/Dummy/team_members_list.dart';
import 'package:plasma/Model/Models/team_member_model.dart';
import 'package:plasma/View/Mobile/member_info_screen.dart';

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
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png',),
              backgroundColor: Colors.white,
              radius: 18,
            ),
            SizedBox(width: 10,),
            Text('Developers Team'),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 15),
          itemBuilder: (context, index) => ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MemberInfoScreen(memberModel: _members[index]),
                  ),
                ),
                title: Text(_members[index].name,style: const TextStyle(fontWeight: FontWeight.bold),),
              ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: _members.length),
    );
  }
}
