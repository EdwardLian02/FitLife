import 'package:fit_life/model/progress.dart';
import 'package:fit_life/service/database_service.dart';
import 'package:fit_life/viewModel/session_viewModel.dart';
import 'package:flutter/material.dart';

class ProgressViewModel extends ChangeNotifier {
  final _dbService = DatabaseService();
  final sessionViewModel = SessionViewModel();

  Future<void> addProgress(sessionData, ProgressModel progressData,
      SessionViewModel sessionViewModel) async {
    await _dbService.createProgress(sessionData['sid'], progressData.toMap());

    sessionData['progress'] = progressData.toMap();
    sessionViewModel.assignSessionDetail(sessionData);
  }
}
