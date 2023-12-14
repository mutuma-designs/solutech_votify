import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';
import 'utils/provider_logger.dart';
import 'features/features.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final providerContainer = ProviderContainer();
  await Hive.initFlutter();
  await features.preregister();
  await providerContainer.read(authStateProvider.notifier);

  runApp(
    ProviderScope(
      parent: providerContainer,
      observers: [ProviderLogger()],
      child: const App(),
    ),
  );
}
