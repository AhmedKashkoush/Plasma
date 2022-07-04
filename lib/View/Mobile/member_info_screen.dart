import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plasma/Model/Models/team_member_model.dart';
import 'package:plasma/View/Widgets/link_widget.dart';
import 'package:plasma/View/Widgets/toast_widget.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';

class MemberInfoScreen extends StatelessWidget {
  final TeamMemberModel memberModel;

  const MemberInfoScreen({Key? key, required this.memberModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TranslatedTextWidget(text: 'Developer Info'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TranslatedTextWidget(
              text: memberModel.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 75,
            ),
            TranslatedTextWidget(
              text: 'Contact',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.github),
              title: LinkWidget(
                link: memberModel.gitHub,
              ),
              trailing: IconButton(
                onPressed: () async {
                  await FlutterClipboard.copy(memberModel.gitHub);
                  HapticFeedback.vibrate();
                  ToastWidget.showToast(context, msg: TranslatedTextWidget.translate('Copied To Clipboard'));
                },
                icon: Icon(Icons.copy),
              ),
            ),
            if (memberModel.linkedIn != '')
              ListTile(
                leading: FaIcon(FontAwesomeIcons.linkedin),
                title: LinkWidget(
                  link: memberModel.linkedIn,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await FlutterClipboard.copy(memberModel.linkedIn);
                    HapticFeedback.vibrate();
                    ToastWidget.showToast(context, msg: TranslatedTextWidget.translate('Copied To Clipboard'));
                  },
                  icon: Icon(Icons.copy),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
