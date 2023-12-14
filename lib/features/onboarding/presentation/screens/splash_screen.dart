import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/utils/utils.dart';

import '../../../../config/constants.dart';
import '../../../../config/images.dart';
import '../../../auth/auth.dart';
import '../../../elections/presentation/screens/elections_screen.dart';
import '../controllers/onboarding_controller.dart';
import '../states/onboarding_state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static String routePath = "/splash";
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  navigateToElectionsScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go(ElectionsScreen.routePath);
    }
  }

  navigateToSetupScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go(SetupScreen.routePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<OnboardingState>(onboardingStateProvider, (prev, next) async {
      if (next is OnboardingError) {
        next.failure.showSnackBar(context);
      }

      if (next is OnboardingCompleted) {
        navigateToElectionsScreen();
      }

      if (next is OnboardingNotCompleted) {
        navigateToSetupScreen();
      }
    });

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Image.asset(Images.appIcon, width: 100, height: 100),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Text(
                  appTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  appVersion,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black38,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
