import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/controllers/quiz/quiz_controller.dart';
import 'package:quiz_app/controllers/quiz/quiz_state.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/repositories/quiz/quiz_repository.dart';
import 'package:quiz_app/widgets/custom_button.dart';

class QuizResult extends ConsumerWidget {
  final QuizState state;
  final List<Question> questions;
  const QuizResult({
    super.key,
    required this.state,
    required this.questions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.correct.length} / ${questions.length}',
          style: const TextStyle(
              color: Colors.white, fontSize: 60.0, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const Text(
          '正解',
          style: TextStyle(
              color: Colors.white, fontSize: 48.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 40.0,
        ),
        CustomButton(
            title: '新しい問題',
            onTap: () {
              ref.refresh(quizRepositoryProvider);
              ref.read(quizControllerProvider.notifier).reset();
            })
      ],
    );
  }
}
