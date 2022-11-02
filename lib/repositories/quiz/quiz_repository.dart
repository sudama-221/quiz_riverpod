import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/enums/difficulty.dart';
import 'package:quiz_app/models/failure_model.dart';
import 'package:quiz_app/models/question_model.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

abstract class BaseQuizRepository {
  Future<List<Question>> getQuestion(
      {required int numQuestions,
      required int categoryId,
      required Difficulty difficulty});
}

final quizRepositoryProvider =
    Provider<BaseQuizRepository>((ref) => QuizRepository(ref));

class QuizRepository implements BaseQuizRepository {
  final Ref _ref;
  const QuizRepository(this._ref);

  @override
  Future<List<Question>> getQuestion(
      {required int numQuestions,
      required int categoryId,
      required Difficulty difficulty}) async {
    try {
      final queryParameters = {
        'type': 'multiple',
        'amount': numQuestions,
        'category': categoryId
      };

      if (difficulty != Difficulty.any) {
        queryParameters
            .addAll({'difficulty': EnumToString.convertToString(difficulty)});
      }

      final response = await _ref
          .read(dioProvider)
          .get('https://opentdb.com/api.php', queryParameters: queryParameters);

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data['results'] ?? []);
        if (results.isNotEmpty) {
          return results.map((e) => Question.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response!.statusMessage!);
    } on SocketException catch (err) {
      print(err);
      throw const Failure(message: '接続を確認してください');
    }
  }
}
