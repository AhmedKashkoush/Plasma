import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;

enum NotificationType {
  reservation,
  reminder,
  questionnaire,
  analysisResult,
  bonus,
  auth,
  user,
}

class NotificationWidget extends StatefulWidget {
  final String title;
  final String? body;
  final DateTime time;
  final bool isOpened;
  final VoidCallback onTap;
  final NotificationType type;

  const NotificationWidget({
    Key? key,
    required this.title,
    this.body,
    required this.time,
    required this.type,
    this.isOpened = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String timeFormat =
        TimeOfDay(hour: widget.time.hour, minute: widget.time.minute)
            .format(context);
    return InkWell(
      onTap: widget.onTap,
      onLongPress: () {
        HapticFeedback.vibrate();
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        color: !widget.isOpened
            ? Colors.orangeAccent.withOpacity(0.1)
            : Colors.transparent,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: _checkTypeToColor(),
              child: Icon(
                _checkTypeToIcon(),
                size: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  widget.body != null
                      ? Text(
                          widget.body!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox()
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  enableFeedback: false,
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz),
                ),
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: !widget.isOpened,
                  child: Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                  ),
                  child: Text(
                    timeFormat,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _checkTypeToIcon() {
    switch (widget.type) {
      case NotificationType.reservation:
        return Icons.event_note;
      case NotificationType.reminder:
        return Icons.alarm;
      case NotificationType.questionnaire:
        return Icons.content_paste_sharp;
      case NotificationType.analysisResult:
        return Icons.analytics_outlined;
      case NotificationType.bonus:
        return Icons.add;
      case NotificationType.auth:
        return Icons.security;
      case NotificationType.user:
        return Icons.account_circle;
    }
  }

  Color _checkTypeToColor() {
    switch (widget.type) {
      case NotificationType.reservation:
        return Colors.amber;
      case NotificationType.reminder:
        return Colors.teal;
      case NotificationType.questionnaire:
        return Colors.blueAccent;
      case NotificationType.analysisResult:
        return Colors.indigo;
      case NotificationType.bonus:
        return Colors.red.shade800;
      case NotificationType.auth:
        return Colors.blueGrey;
      case NotificationType.user:
        return Colors.green.shade800;
    }
  }
}

class NotificationLoadingWidget extends StatefulWidget {
  const NotificationLoadingWidget({Key? key}) : super(key: key);

  @override
  _NotificationLoadingWidgetState createState() =>
      _NotificationLoadingWidgetState();
}

class _NotificationLoadingWidgetState extends State<NotificationLoadingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation =
        Tween<double>(begin: 0.05, end: 1).animate(_animationController!);
    _animationController
      ?..forward()
      ..repeat(reverse: true, min: 0.2, max: 1)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: Colors.transparent,
      child: AnimatedOpacity(
        opacity: _animation!.value,
        duration: _animationController!.duration!,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 8,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
