import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingWidget extends StatelessWidget {
  final double initialRate;
  final void Function(double) onRatingUpdate;

  const RatingWidget(
      {Key? key, this.initialRate = 0, required this.onRatingUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return const Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.orange,
            );
          case 2:
            return const Icon(
              Icons.sentiment_neutral,
              color: Colors.yellow,
            );
          case 3:
            return const Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return const Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return SizedBox();
        }
      },
      tapOnlyMode: true,
      onRatingUpdate: onRatingUpdate,
      itemCount: 5,
      initialRating: initialRate,
      unratedColor: Colors.grey,
      itemSize: 50,
    );
  }
}
