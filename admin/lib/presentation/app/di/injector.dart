// ignore_for_file: cascade_invocations

import 'package:get_it/get_it.dart';
import 'package:survey_admin/presentation/app/app_cubit.dart';
import 'package:survey_admin/presentation/pages/builder/builder_cubit.dart';
import 'package:survey_admin/presentation/pages/new_question_page/new_question_cubit.dart';

GetIt get i => GetIt.instance;

Future<void> initInjector() async {
  _initDataSources();
  _initRepositories();
  _initCubits();
}

Future<void> _initDataSources() async {}

void _initCubits() {
  i.registerFactory<AppCubit>(AppCubit.new);
  i.registerFactory<BuilderCubit>(BuilderCubit.new);
  i.registerFactory<NewQuestionCubit>(NewQuestionCubit.new);
}

void _initRepositories() {}
