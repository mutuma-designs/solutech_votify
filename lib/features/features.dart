import 'package:core/core.dart';
import 'package:solutech_votify/features/positions/positions.dart';
import 'package:solutech_votify/features/settings/settings.dart';
import 'package:solutech_votify/features/users/users.dart';

import 'auth/auth.dart';
import 'elections/elections.dart';
import 'home/home.dart';
import 'onboarding/onboarding.dart';
import 'roles/roles.dart';
import 'verification/verification.dart';
import 'voting/voting.dart';

List<Feature> features = [
  OnboardingFeature(),
  AuthFeature(),
  HomeFeature(),
  SettingsFeature(),
  ElectionsFeature(),
  PositionsFeature(),
  VerificationFeature(),
  UsersFeature(),
  RolesFeature(),
  VotingFeature(),
];
