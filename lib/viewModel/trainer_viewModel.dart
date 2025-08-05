import 'package:fit_life/model/user.dart';
import 'package:fit_life/service/database_service.dart';
import 'package:fit_life/viewModel/auth_viewModel.dart';
import 'package:flutter/material.dart';

class TrainerViewModel extends ChangeNotifier {
  final _dbService = DatabaseService();

  //Edit trainer(User info)
  Future<bool> editUserInfo(
      TrainerModel? user, AuthViewModel authViewModel) async {
    if (user != null) {
      await _dbService.updateUserData(user);
      await authViewModel.saveCurrentLoginUser();
      return true;
    } else {
      return false;
    }
  }
}
