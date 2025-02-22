import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CountdownTimer extends StatefulWidget {
  final int restTimeSecond;
  const CountdownTimer({
    super.key,
    required this.restTimeSecond,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  final CountdownController _controller = CountdownController(autoStart: false);
  bool isStarted = false;
  bool isPaused = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Countdown(
            controller: _controller,
            seconds: widget.restTimeSecond,
            build: (_, double time) => isStarted
                ? TextButton.icon(
                    style: const ButtonStyle(
                      iconSize: WidgetStatePropertyAll(26),
                      // iconColor: WidgetStatePropertyAll(Colors.cyanAccent),
                    ),
                    onPressed: () {
                      if (isPaused) {
                        _controller.resume();
                        setState(() {
                          isPaused = false;
                        });
                      } else {
                        _controller.pause();
                        setState(() {
                          isPaused = true;
                        });
                      }
                    },
                    label: Text(
                      time.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    icon: isPaused
                        ? const Icon(Icons.play_arrow_rounded,
                            color: Color(0xFF05b6ca))
                        : const Icon(Icons.pause, color: Color(0xFF05b6ca)),
                    iconAlignment: IconAlignment.start,
                  )
                : TextButton.icon(
                    style: const ButtonStyle(
                      iconSize: WidgetStatePropertyAll(26),
                      // iconColor: WidgetStatePropertyAll(color),
                    ),
                    onPressed: () {
                      if (!isStarted) {
                        _controller.start();
                        setState(() {
                          isStarted = true;
                        });
                      }
                    },
                    label: const Text(
                      'Start',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    icon: const Icon(
                      Icons.access_time_rounded,
                      color: Color(0xFF05b6ca),
                    ),
                    iconAlignment: IconAlignment.start,
                  ),
            interval: const Duration(milliseconds: 1000),
            onFinished: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Timer Finished'),
                    content: const Text(
                        'The countdown timer has completed. Go back to next set!!!'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text(
                          'OK',
                          style: TextStyle(fontSize: 30),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            })
      ],
    );
  }
}
