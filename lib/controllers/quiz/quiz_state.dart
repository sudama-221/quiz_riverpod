import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:meta/meta_meta.dart';

enum QuizStatus { initial, correct, incorrect, complete }
// イニシャル、正しい、正しくない、完了

class QuizState extends Equatable {
  final String selectedAnswer; // 選んだこたえ
  final List<Question> correct; // あっていた問題
  final List<Question> incorrect; // 間違っていた問題
  final QuizStatus status; // 問題のステータス

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  const QuizState(
      {required this.selectedAnswer,
      required this.correct,
      required this.incorrect,
      required this.status});

  // デフォルトの状態
  factory QuizState.initial() {
    return const QuizState(
        selectedAnswer: '',
        correct: [],
        incorrect: [],
        status: QuizStatus.initial);
  }

  @override
  List<Object?> get props => [selectedAnswer, correct, incorrect, status];

  QuizState copyWith({
    String? selectedAnswer,
    List<Question>? correct,
    List<Question>? incorrect,
    QuizStatus? status,
  }) {
    return QuizState(
        selectedAnswer: selectedAnswer ?? this.selectedAnswer,
        correct: correct ?? this.correct,
        incorrect: incorrect ?? this.incorrect,
        status: status ?? this.status);
  }

  //   QuizState copyWith({
  //   required String selectedAnswer,
  //   required List<Question> correct,
  //   required List<Question> incorrect,
  //   required QuizStatus status,
  // }) {
  //   return QuizState(
  //     selectedAnswer: selectedAnswer,
  //     correct: correct,
  //     incorrect: incorrect,
  //     status: status,
  //   );
  // }
}
