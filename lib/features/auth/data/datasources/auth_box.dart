import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../models/auth_data_model.dart';

final authBoxProvider = FutureProvider<Box<AuthDataModel>>((ref) async {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String secureEncryptionKeyKey = 'encryptionKey';

  var containsEncryptionKey =
      await secureStorage.containsKey(key: secureEncryptionKeyKey);

  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(
        key: secureEncryptionKeyKey, value: base64UrlEncode(key));
  }

  var encryptionKeyString =
      await secureStorage.read(key: secureEncryptionKeyKey);

  var encryptionKey = base64Url.decode(encryptionKeyString!);

  final box = await Hive.openBox<AuthDataModel>("auth",
      encryptionCipher: HiveAesCipher(encryptionKey));

  ref.onDispose(() async {
    await box.close();
  });
  return box;
});
