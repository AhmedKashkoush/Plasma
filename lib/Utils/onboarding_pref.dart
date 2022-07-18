import 'package:plasma/Utils/shared_preferences_api.dart';

class OnBoardingPref {
  static bool _skippedOnBoarding = false;
  static bool get skippedOnBoarding => _skippedOnBoarding;
  static Future<void> hasSkippedOnBoarding() async {
    _skippedOnBoarding = await SharedPreferencesApi.getBool('on_boarding')?? false;
  }
}