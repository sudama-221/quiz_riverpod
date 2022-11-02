import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/controllers/quiz/quiz_controller.dart';
import 'package:quiz_app/controllers/quiz/quiz_state.dart';
import 'package:quiz_app/models/failure_model.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/pages/quiz_error.dart';
import 'package:quiz_app/widgets/custom_button.dart';
import 'package:quiz_app/widgets/quiz_questions.dart';
import 'package:quiz_app/widgets/quiz_results.dart';

// class QuizPage extends ConsumerWidget {
//   const QuizPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final quizQuestions = ref.watch(quizQuestionsProvider);
//     final PageController pageController = PageController();
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Color(0xFFD4418E), Color(0xFF0652C5)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight)),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: quizQuestions.when(
//           data: (questions) =>
//               _buildBody(context, ref, pageController, questions),
//           error: (error, _) => QuizError(
//               message: error is Failure ? error.message : 'エラーが発生しました'),
//           loading: () => const Center(
//             child: CircularProgressIndicator(),
//           ),
//         ),
//         bottomSheet: quizQuestions.maybeWhen(
//           orElse: () => const SizedBox.shrink(),
//           data: (questions) {
//             final quizState = ref.watch(quizControllerProvider);
//             if (!quizState.answered) return const SizedBox.shrink();
//             print('ここまで');
//             return CustomButton(
//                 title: pageController.page!.toInt() + 1 < questions.length
//                     ? '次の問題へ'
//                     : '結果を見る',
//                 onTap: () {
//                   ref
//                       .read(quizControllerProvider.notifier)
//                       .nextQuestion(questions, pageController.page!.toInt());
//                   if (pageController.page!.toInt() + 1 < questions.length) {
//                     pageController.nextPage(
//                         duration: const Duration(milliseconds: 250),
//                         curve: Curves.linear);
//                   }
//                 });
//           },
//         ),
//       ),
//     );
//   }
// }

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  int controllerPageCount = 0;

  changePage(int page, int length) {
    setState(() {
      if (page < length) {
        controllerPageCount = page + 1;
      } else {
        controllerPageCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizQuestions = ref.watch(quizQuestionsProvider);
    final pageCount = ref.watch(pageCounterProvider);
    print(pageCount);

    final PageController pageController = PageController();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFD4418E), Color(0xFF0652C5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: quizQuestions.when(
          data: (questions) =>
              _buildBody(context, ref, pageController, questions),
          error: (error, _) => QuizError(
              message: error is Failure ? error.message : 'エラーが発生しました'),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        bottomSheet: quizQuestions.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (questions) {
            final quizState = ref.watch(quizControllerProvider);
            if (!quizState.answered) return const SizedBox.shrink();
            return CustomButton(
                title: pageCount < questions.length ? '次の問題へ' : '結果を見る',
                onTap: () {
                  ref
                      .read(quizControllerProvider.notifier)
                      .nextQuestion(questions, pageCount);
                  if (pageCount < questions.length) {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.linear);
                    ref.read(pageCounterProvider.notifier).increment();
                  }
                });
          },
        ),
      ),
    );
  }
}

Widget _buildBody(BuildContext context, WidgetRef ref,
    PageController pageController, List<Question> questions) {
  if (questions.isEmpty) return QuizError(message: '問題が見つかりません');

  final quizState = ref.watch(quizControllerProvider);
  return quizState.status == QuizStatus.complete
      ? QuizResult(state: quizState, questions: questions)
      : QuizQuestions(
          state: quizState,
          questions: questions,
          pageController: pageController);
}
