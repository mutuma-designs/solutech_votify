import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../states/onboarding_state.dart';

class OnboardingController extends StateNotifier<OnboardingState> {
  GetOnboardingStatus getOnboardingStatusUseCase;
  OnboardingController({
    required this.getOnboardingStatusUseCase,
  }) : super(OnboardingInitial()){
    getStatus();
  }

  Future<void> getStatus() async {
    state = OnboardingLoading();
    var response = await getOnboardingStatusUseCase();
    response.fold((l) {
      state = OnboardingError(l);
    }, (r) {
      state = r ? OnboardingCompleted() : OnboardingNotCompleted();
    });
  }
}

final onboardingStateProvider =
    StateNotifierProvider.autoDispose<OnboardingController, OnboardingState>(
        (ref) {
  final getOnboardingStatusUseCase =
      ref.watch(getOnboardingStatusUseCaseProvider);
  return OnboardingController(
    getOnboardingStatusUseCase: getOnboardingStatusUseCase,
  );
});
