import 'package:flutter/material.dart';

class BloodLoadingIndicator extends StatefulWidget {
  final Duration? duration;
  final Color? color;
  const BloodLoadingIndicator(
      {Key? key, this.duration = const Duration(milliseconds: 700), this.color})
      : super(key: key);

  @override
  _BloodLoadingIndicatorState createState() => _BloodLoadingIndicatorState();
}

class _BloodLoadingIndicatorState extends State<BloodLoadingIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward()
      ..repeat(
        reverse: true,
      )
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0.1, end: 1).animate(_controller!);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _animation!.value,
      duration: _controller!.duration!,
      child: AnimatedScale(
        scale: 2 + 1.5*_animation!.value,
        duration: _controller!.duration!,
        child: Icon(
          Icons.water_drop_rounded,
          color: widget.color ?? Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
