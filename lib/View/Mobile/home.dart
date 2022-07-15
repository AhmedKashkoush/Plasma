import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plasma/Model/Models/reservation_model.dart';
import 'package:plasma/Utils/auth.dart';
import 'package:plasma/View/Mobile/before_questions.dart';
import 'package:plasma/View/Widgets/reservation_banner_widget.dart';
import 'package:plasma/View/Widgets/translated_text_widget.dart';
import 'package:plasma/ViewModel/reservation_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<CurvedNavigationBarState> bottomBarKey;

  const HomeScreen({Key? key, required this.bottomBarKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReservationViewModel _vm = Provider.of<ReservationViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: GestureDetector(
          onTap: () => bottomBarKey.currentState?.setPage(3),
          child: Text(
            '${AuthHelper.currentUser?.firstName} ${AuthHelper.currentUser?.lastName}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () => bottomBarKey.currentState?.setPage(3),
          child: AuthHelper.currentUser?.image != null &&
                  AuthHelper.currentUser?.image != ""
              ? Transform.scale(
                  scale: 0.5,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.transparent,
                    backgroundImage: CachedNetworkImageProvider(
                      '${AuthHelper.currentUser?.image}',
                      cacheKey: '${AuthHelper.currentUser?.image}',
                    ),
                  ),
                )
              : Icon(
                  Icons.account_circle,
                  size: 32,
                  color: Theme.of(context).primaryColor,
                ),
        ),
      ),
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 56),
                        child: Column(
                          children: [
                            Container(
                              //height: 40.0,
                              width: double.infinity,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: TranslatedTextWidget(
                                text: 'Most Sick People Need Blood Plasma',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TranslatedTextWidget(
                              text:
                                  'Donate and help them treat many diseases that threaten their lives.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                              ),
                            ),
                            Divider(
                              indent: 35,
                              endIndent: 35,
                              thickness: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                            const Image(
                              width: 450,
                              image: AssetImage(
                                'assets/images/imgHome.png',
                              ),
                            ),
                            Divider(
                              indent: 70,
                              endIndent: 70,
                              thickness: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Donate now button
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: FutureBuilder<ReservationModel>(
                future: _vm.getReservation(),
                builder: (context, AsyncSnapshot<ReservationModel> snapshot) {
                  _vm.setContext(context);
                  if (!snapshot.hasData)
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  ReservationModel model = snapshot.data!;
                  bool reserved = model.time != '' &&
                      model.date != '' &&
                      model.place != '' &&
                      model.questionsAnswers != [];
                  if (reserved)
                    return ReservationBannerWidget(
                        model: model);
                  else if (!snapshot.hasError)
                    return MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 44,
                        vertical: 4,
                      ),
                      color: Theme.of(context).primaryColor,
                      elevation: 15,
                      onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BeforeQuestions(),
                          ),
                        ),
                      },
                      child: TranslatedTextWidget(
                        text: 'Donate Now',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    );
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 44,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                    ),
                    child: TranslatedTextWidget(
                      text: 'Check Your Internet Connection',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
