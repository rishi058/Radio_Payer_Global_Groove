import 'dart:async';
import 'package:flutter/material.dart';
import 'package:global_groove/sizer/sizer.dart';
import '../controller/audio_controller/audio_controllers.dart';


class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key,
    required this.textSize,
  });

  final double textSize;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  String duration = "0:00";
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    refresh();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      refresh();
    });
  }

  void refresh() {
    if (AudioController.audioStartTime != null) {
      Duration res = DateTime.now().difference(AudioController.audioStartTime!);
      int minutes = res.inMinutes;
      int seconds = res.inSeconds % 60;
      duration = '$minutes:${seconds.toString().padLeft(2, '0')}';
      setState(() {});
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(duration, style: TextStyle(fontSize: widget.textSize.sp));
  }
}
