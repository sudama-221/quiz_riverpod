import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuizError extends StatelessWidget {
  final String message;
  const QuizError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
