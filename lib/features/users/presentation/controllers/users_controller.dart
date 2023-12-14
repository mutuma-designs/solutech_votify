import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';
import '../states/users_state.dart';

class UsersController extends StateNotifier<UsersState> {
  GetUsers getUsersUseCase;
  UsersController({
    required this.getUsersUseCase,
  }) : super(UsersInitial()) {
    getUsers();
  }

  void getUsers() async {
    state = UsersLoading(
      state.users,
    );
    var response = await getUsersUseCase();

    await response.fold((failure) {
      state = LoadingUsersFailed(failure);
    }, (users) async {
      if (users.isEmpty) {
        state = UsersEmpty();
        return;
      }
      state = UsersLoaded(users);
    });
  }
}

final usersStateProvider =
    StateNotifierProvider.autoDispose<UsersController, UsersState>((ref) {
  GetUsers getUsersUseCase = ref.watch(getUsersUseCaseProvider);

  return UsersController(
    getUsersUseCase: getUsersUseCase,
  );
});

final userProvider = Provider.autoDispose.family<User?, int>((ref, id) {
  final usersState = ref.watch(usersStateProvider);
  return usersState.users.firstWhereOrNull(
    (element) => element.id == id,
  );
});

final userSearchQueryProvider = StateProvider.autoDispose<String>((ref) => "");

final filteredUsersProvider = Provider.autoDispose<List<User>>((ref) {
  final usersState = ref.watch(usersStateProvider);
  final query = ref.watch(userSearchQueryProvider);
  return usersState.users
      .where(
        (element) => element.fullName.toLowerCase().contains(
              query.toLowerCase(),
            ),
      )
      .toList();
});
