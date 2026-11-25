import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static late HiveAesCipher _keyHiveAesCipher;
  static const String _keyName = "keyName";

  static Future<void> _init() async {
    await Hive.initFlutter();
  }

  static Future<void> init(List<String>? openedBoxes) async {
    late List<int> cipherKey;

    await _init();

    try {
      // Timeout to prevent hang on devices with broken Android Keystore
      String? storedKey = await secureStorage
          .read(key: _keyName)
          .timeout(const Duration(seconds: 5));

      if (storedKey != null) {
        cipherKey = base64Decode(storedKey);
      } else {
        cipherKey = Hive.generateSecureKey();
        await secureStorage
            .write(key: _keyName, value: base64UrlEncode(cipherKey))
            .timeout(const Duration(seconds: 5));
      }
    } catch (e) {
      log('SecureStorage failed: $e — generating a new key');
      // If SecureStorage is broken, generate a fresh key.
      // User will lose encrypted data (need re-login), but app won't hang.
      cipherKey = Hive.generateSecureKey();
      try {
        await secureStorage.deleteAll().timeout(const Duration(seconds: 3));
        await secureStorage
            .write(key: _keyName, value: base64UrlEncode(cipherKey))
            .timeout(const Duration(seconds: 3));
      } catch (_) {
        log(
          'SecureStorage write retry also failed — continuing with in-memory key',
        );
      }
    }

    _keyHiveAesCipher = HiveAesCipher(cipherKey);

    for (String box in openedBoxes ?? []) {
      await _openBox(box);
    }
  }

  static Future<void> _openBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) return;
    try {
      await Hive.openBox(boxName, encryptionCipher: _keyHiveAesCipher);
    } catch (e) {
      log('Failed to open box "$boxName": $e — deleting and recreating');
      // Box is corrupted (e.g. key changed), delete and start fresh
      await Hive.deleteBoxFromDisk(boxName);
      await Hive.openBox(boxName, encryptionCipher: _keyHiveAesCipher);
    }
  }

  static Future<void> putRaw(String boxName, String key, dynamic value) async {
    await _openBox(boxName);
    await Hive.box(boxName).put(key, value);
  }

  static dynamic getRaw({required String boxName, required String key}) {
    final item = Hive.box(boxName).get(key);
    return item;
  }

  static Future<void> putJson(
    String boxName,
    String key,
    Map<String, dynamic> json,
  ) async {
    final jsonString = jsonEncode(json);
    await putRaw(boxName, key, jsonString);
  }

  static Future<Map<String, dynamic>?> getJson(
    String boxName,
    String key,
  ) async {
    final jsonString = await getRaw(boxName: boxName, key: key);
    if (jsonString is String) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> remove(String boxName, String key) async {
    await _openBox(boxName);
    await Hive.box(boxName).delete(key);
  }

  static Future<void> clearBox(String boxName) async {
    await Hive.box(boxName).clear();
  }

  static Future<bool> contains(String boxName, String key) async {
    await _openBox(boxName);
    return Hive.box(boxName).containsKey(key);
  }

  static ValueListenable listenable(String boxName) {
    final box = Hive.box(boxName);
    return box.listenable();
  }
}
