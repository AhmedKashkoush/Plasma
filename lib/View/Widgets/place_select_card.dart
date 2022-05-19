import 'package:flutter/material.dart';

class PlaceSelectCard extends StatelessWidget {
  final String placeName;
  final VoidCallback? onTap;
  const PlaceSelectCard({Key? key, required this.placeName, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      elevation: 2.0,
      // minWidth: 200.0,
      // height: 35,
      color: Theme.of(context).brightness == Brightness.light?Theme.of(context).primaryColor:Colors.grey.shade800,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                Color.fromARGB(255, 204, 194, 194),
                radius: 20,
                child: Image.asset(
                  'images/plasma-marker.png',
                  width: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    placeName,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
