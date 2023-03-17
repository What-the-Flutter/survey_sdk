import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_admin/domain/repository_interfaces/file_system_repository.dart.dart';
import 'package:survey_admin/domain/repository_interfaces/session_storage_repository.dart';
import 'package:survey_admin/presentation/pages/builder/builder_state.dart';
import 'package:survey_core/survey_core.dart';

class BuilderCubit extends Cubit<BuilderState> {
  final FileSystemRepository _fileSystemRepository;
  final SessionStorageRepository _sessionStorageRepository;

  BuilderCubit(
    this._fileSystemRepository,
    this._sessionStorageRepository,
  ) : super(
          BuilderState(
            surveyData: SurveyData.common(),
            selectedQuestion: null,
          ),
        ) {
    _init();
  }

  void downloadExportedQuestions() {
    final questions = state.surveyData.questions;
    if (questions.isNotEmpty) {
      final rawMap = <String, dynamic>{};
      for (final element in questions) {
        rawMap[element.index.toString()] = element.toJson();
      }
      _fileSystemRepository.downloadSurveyData(rawMap);
    }
  }

  void select(QuestionData data) {
    emit(state.copyWith(selectedQuestion: data));
  }

  void addQuestionData(QuestionData data) {
    final questionList = List<QuestionData>.of(state.surveyData.questions)
      ..add(data);
    final surveyData = state.surveyData.copyWith(questions: questionList);
    _sessionStorageRepository.saveSurveyData(surveyData);
    emit(state.copyWith(surveyData: surveyData));
  }

  // TODO(message): show message in case of error/empty data.
  Future<void> importData() async {
    final surveyData = await _fileSystemRepository.importSurveyData();
    if (surveyData != null) {
      emit(
        state.copyWith(surveyData: surveyData),
      );
    }
  }

  void _init() {
    final surveyData =
        _sessionStorageRepository.getSurveyData() ?? SurveyData.common();
    emit(state.copyWith(surveyData: surveyData));
  }
}
