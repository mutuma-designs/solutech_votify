import 'package:core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solutech_votify/features/auth/domain/domain.dart';

enum AuthStatus {
  initial,
  loggingIn,
  loggingOut,
  loggoutFailed,
  registering,
  registrationFailed,
  sendingInstructionsFailed,
  sendingInstructions,
  sentInstructions,
  registered,
  authenticated,
  unauthenticated,
}

typedef AuthState = ValueState<User, AuthStatus>;

class AuthController extends Notifier<AuthState> {
  @override
  build() {
    return AuthState.initial(AuthStatus.initial);
  }

  void login(LoginParams params) async {
    state = state.copyWith(status: AuthStatus.loggingIn);

    final loginUseCase = ref.read(loginUseCaseProvider);
    final response = await loginUseCase(params);

    response.fold((failure) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        failure: failure,
      );
    }, (User user) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        value: user,
      );
    });
  }

  void setup(SetupAccountParams params) async {
    state = state.copyWith(status: AuthStatus.registering);

    final registerUseCase = ref.read(registerUseCaseProvider);
    final response = await registerUseCase(
      params,
    );

    response.fold((failure) {
      state = state.copyWith(
        status: AuthStatus.registrationFailed,
        failure: failure,
      );
    }, (_) {
      state = state.copyWith(
        status: AuthStatus.registered,
      );
    });
  }

  Future<void> logout() async {
    state = state.copyWith(status: AuthStatus.loggingOut);

    final logoutUseCase = ref.read(logoutUseCaseProvider);
    final response = await logoutUseCase();

    response.fold((failure) {
      state =
          state.copyWith(status: AuthStatus.loggoutFailed, failure: failure);
    }, (success) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    });
  }
}

final authStateProvider = NotifierProvider<AuthController, AuthState>(() {
  return AuthController();
});
