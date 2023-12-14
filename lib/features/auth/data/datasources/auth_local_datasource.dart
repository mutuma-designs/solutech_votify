import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../users/data/models/user_model.dart';
import '../models/auth_data_model.dart';
import 'auth_box.dart';

abstract class AuthLocalDataSource implements LocalDataSource {
  Future<UserModel> getUser();
  Future<String?> getToken();
  Future<void> save(AuthDataModel authData);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  Future<Box<AuthDataModel>> getBox;
  AuthLocalDataSourceImpl({
    required this.getBox,
  });

  @override
  Future<void> save(AuthDataModel authData) async {
    return handleErrors(() async {
      var box = await getBox;
      await box.clear();
      await box.add(authData);
    });
  }

  @override
  Future<UserModel> getUser() async {
    return handleErrors(() async {
      var box = await getBox;
      if (box.values.isEmpty) {
        throw NotFoundException();
      }
      return box.values.first.user;
    });
  }

  @override
  Future<String?> getToken() async {
    try {
      var box = await getBox;
      if (box.values.isEmpty) {
        return null;
      }
      var authData = box.values.first;
      return authData.token;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clear() async {
    return handleErrors(() async {
      var box = await getBox;
      await box.clear();
    });
  }
}

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  var authBox = ref.watch(authBoxProvider.future);
  return AuthLocalDataSourceImpl(
    getBox: authBox,
  );
});
