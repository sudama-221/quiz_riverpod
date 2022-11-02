import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/controllers/quiz/quiz_state.dart';
import 'package:quiz_app/enums/difficulty.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/repositories/quiz/quiz_repository.dart';

// ページカウンター
final pageCounterProvider = StateNotifierProvider<PageCounter, int>((ref) {
  return PageCounter();
});

class PageCounter extends StateNotifier<int> {
  PageCounter() : super(1);
  void increment() => state++;
  void reset() => state = 1;
}

final quizQuestionsProvider =
    FutureProvider.autoDispose<List<Question>>((ref) async {
  return ref.watch(quizRepositoryProvider).getQuestion(
      numQuestions: 5,
      categoryId: Random().nextInt(24) + 9, // categoryが9から始まるので
      difficulty: Difficulty.any);
});

final quizControllerProvider =
    StateNotifierProvider.autoDispose<QuizControllerNotifier, QuizState>(
        (ref) => QuizControllerNotifier(ref));

class QuizControllerNotifier extends StateNotifier<QuizState> {
  final Ref _ref;
  QuizControllerNotifier(this._ref) : super(QuizState.initial());

  // 答えを送信
  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return; // ?

    print(state.correct);

    // 選んだ答えが正解と一致している（正解）
    if (currentQuestion.correctAnswer == answer) {
      state = state.copyWith(
          selectedAnswer: answer,
          // correct: state.correct..add(currentQuestion),
          correct: [...state.correct, currentQuestion],
          status: QuizStatus.correct);
    } else {
      // 間違いの場合
      state = state.copyWith(
          selectedAnswer: answer,
          incorrect: [...state.incorrect, currentQuestion],
          status: QuizStatus.incorrect);
    }
  }

  // 次の問題
  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
        selectedAnswer: '',
        status: currentIndex < questions.length
            ? QuizStatus.initial // デフォルト
            : QuizStatus.complete // 完了
        );
  }

  // リセット
  void reset() {
    _ref.read(pageCounterProvider.notifier).reset();
    state = QuizState.initial();
  }
}
