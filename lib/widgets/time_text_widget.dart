import 'dart:async';

import 'package:flutter/material.dart';

import '../helpers/helper_functions.dart';

class TimeTextWidget extends StatefulWidget {
  const TimeTextWidget({super.key, required this.timezone});

  final int timezone;

  @override
  State<TimeTextWidget> createState() => _TimeTextWidgetState();
}

class _TimeTextWidgetState extends State<TimeTextWidget> {
  late final Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      changeTimeToAnotherTimeZone(
        DateTime.now(),
        widget.timezone,
      ),
    );
  }
}
