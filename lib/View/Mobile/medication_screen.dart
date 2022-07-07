import 'package:flutter/material.dart';

import '../../Utils/utils.dart';
import '../Widgets/custom_text_field.dart';
import '../Widgets/translated_text_widget.dart';

class MedicationScreen extends StatefulWidget {
  final PageController pageController;

  const MedicationScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
          reverse: true,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    const SizedBox(
                        height: 150,
                        child: Image(
                          image: AssetImage('assets/images/logo.png'),
                        )),
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Center(
                      child: TranslatedTextWidget(
                        text:
                            'If you are taking any medication, please let us know',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    CustomTextField(
                      controller: textController,
                      hint: 'Write medication names',
                      onChanged: (s) {
                        setState(() {});
                      },
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade800,
                        onPrimary: Colors.white,
                        elevation: 0,
                      ),
                      onPressed: textController.text.isNotEmpty
                          ? () async {
                              // showDialog(
                              //   context: context,
                              //   barrierDismissible: false,
                              //   builder: (context) => WillPopScope(
                              //     onWillPop: () async {
                              //       return false;
                              //     },
                              //     child: AlertDialog(
                              //       backgroundColor: Colors.transparent,
                              //       elevation: 0,
                              //       content: Container(
                              //         padding: const EdgeInsets.all(50),
                              //         decoration: BoxDecoration(
                              //           color: Theme.of(context).scaffoldBackgroundColor,
                              //           borderRadius:
                              //           BorderRadius.circular(25),
                              //         ),
                              //         child: Row(
                              //           mainAxisSize: MainAxisSize.min,
                              //           mainAxisAlignment:
                              //           MainAxisAlignment.spaceEvenly,
                              //           children: const [
                              //             BloodLoadingIndicator(),
                              //             const SizedBox(
                              //               width: 32,
                              //             ),
                              //             Text(
                              //               'Submitting...',
                              //               style: const TextStyle(
                              //                 fontWeight: FontWeight.bold,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // );
                              FocusScope.of(context).unfocus();
                              Utils.showBloodLoadingDialog(
                                context,
                                text: 'Submitting...',
                              );
                              await Future.delayed(const Duration(seconds: 5),
                                  () {
                                Navigator.pop(context);
                              });
                              _moveToNextPage(context);
                            }
                          : null,
                      child: TranslatedTextWidget(
                        text: 'Submit',
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                      onPressed: () => _moveToNextPage(context),
                      child: TranslatedTextWidget(
                        text: 'Skip This Step',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _moveToNextPage(BuildContext context) {
    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    FocusScope.of(context).unfocus();
  }
}
