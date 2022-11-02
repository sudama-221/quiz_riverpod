import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:quiz_app/controllers/quiz/quiz_controller.dart';
import 'package:quiz_app/controllers/quiz/quiz_state.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/widgets/answer_card.dart';

class QuizQuestions extends ConsumerWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;
  const QuizQuestions({
    super.key,
    required this.state,
    required this.questions,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          print(question.correctAnswer);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '問題 ${index + 1} / ${questions.length}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
                child: Text(
                  HtmlCharacterEntities.decode(question.question),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Divider(
                color: Colors.grey[200],
                height: 32.0,
                thickness: 2.0,
                indent: 20.0,
                endIndent: 20.0,
              ),
              Column(
                children: question.answers
                    .map((e) => AnswerCard(
                          answer: e,
                          isSelected: e == state.selectedAnswer,
                          isCorrected: e == question.correctAnswer,
                          isDisplayingAnswer: state.answered,
                          onTap: () => ref
                              .read(quizControllerProvider.notifier)
                              .submitAnswer(question, e),
                        ))
                    .toList(),
              )
            ],
          );
        });
  }
}
