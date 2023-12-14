import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/add_user.dart';
import '../../domain/usecases/delete_user.dart';
import '../../domain/usecases/update_user.dart';
import '../../domain/usecases/upload_users.dart';
import '../states/user_state.dart';

class UserController extends StateNotifier<UserState> {
  AddUser addUserUseCase;
  UpdateUser updateUserUseCase;
  DeleteUser deleteUserUseCase;
  UploadUsers uploadUsersUseCase;

  UserController({
    required this.addUserUseCase,
    required this.updateUserUseCase,
    required this.deleteUserUseCase,
    required this.uploadUsersUseCase,
  }) : super(UserInitial());

  void saveUser({
    required String fullName,
    required String email,
    required DateTime dateOfBirth,
    String? phoneNumber,
    required String status,
    File? photo,
    int? roleId,
    required String gender,
    String? uniqueId,
  }) async {
    state = UserSaving();
    var response = await addUserUseCase(AddUserParams(
      fullName: fullName,
      uniqueId: uniqueId,
      email: email,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
      status: status,
      gender: gender,
      photo: photo,
      roleId: roleId,
    ));
    await response.fold((failure) {
      state = AddingUserFailed(failure);
    }, (success) async {
      state = UserAdded();
    });
  }

  void updateUser({
    required int userId,
    required String fullName,
    required String email,
    required DateTime dateOfBirth,
    required String? phoneNumber,
    required String status,
    required String gender,
    required File? photo,
    int? roleId,
  }) async {
    state = UserSaving();
    var response = await updateUserUseCase(UpdateUserParams(
      userId: userId,
      fullName: fullName,
      email: email,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
      status: status,
      gender: gender,
      photo: photo,
      roleId: roleId,
    ));
    await response.fold((failure) {
      state = UpdatingUserFailed(failure);
    }, (success) async {
      state = UserUpdated();
    });
  }

  void deleteUser(int id) async {
    state = UserDeleting();

    var response = await deleteUserUseCase(DeleteUserParams(userId: id));

    await response.fold((failure) {
      state = DeletingUserFailed(failure);
    }, (success) async {
      state = UserDeleted();
    });
  }

  void uploadUsers(File users) async {
    state = UploadingUsers();

    var response = await uploadUsersUseCase(UploadUsersParams(
      users: users,
    ));

    await response.fold((failure) {
      state = UploadingUsersFailed(failure);
    }, (success) async {
      state = UsersUploaded();
    });
  }
}

final userStateProvider =
    StateNotifierProvider.autoDispose<UserController, UserState>((ref) {
  AddUser addUser = ref.watch(addUserUseCaseProvider);
  UpdateUser updateUser = ref.watch(updateUserUseCaseProvider);
  DeleteUser deleteUser = ref.watch(deleteUserUseCaseProvider);
  UploadUsers uploadUsers = ref.watch(uploadUsersUseCaseProvider);

  return UserController(
    addUserUseCase: addUser,
    updateUserUseCase: updateUser,
    deleteUserUseCase: deleteUser,
    uploadUsersUseCase: uploadUsers,
  );
});
