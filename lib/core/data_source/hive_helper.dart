import 'dart:developer';

import 'package:getin_driver/features/auth/domain/model/auth_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import '../../modules/auth/domain/model/auth_model.dart';
import '../utils/utils.dart';

class DataManager {
  late BoxCollection collection;
  late Box userData;

  static const USER = "USER";
  static const ONBOARDING_SEEN = "ONBOARDING_SEEN";

  Future initHive() async {
    await Hive.initFlutter();
    userData = await Hive.openBox('dataUser');

    // final directory = await getApplicationDocumentsDirectory();
    // collection = await BoxCollection.open(
    //   'dataManager', // Name of your database
    //   {'data'}, // Names of your boxes
    //   path: directory
    //       .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    // );
  }

  Future<void> saveData(String key, dynamic value) async {
    final box = await Hive.openBox('data');
    await box.put(key, value);
  }

  Future<UserModel?> getuser() async {
    try {
      final user = (Map<String, dynamic>.from(userData.get(USER)));
      return UserModel.fromJson(user);
    } catch (e) {
      return null;
    }
  }

  saveUser(Map<String, dynamic> value) async {
    // await Hive.initFlutter();
    // final userData = await Hive.openBox('dataUser');
    await userData.put(USER, value);
  }

  clearUser() async {
    userData.delete(USER);
  }

  getData(String key) async {
    // await Hive.initFlutter();
    final box = await Hive.openBox('data');

    return box.get(key);
  }

  getUserData() async {
    // final userData = await Hive.openBox('dataUser');

    try {
      final user = (Map<String, dynamic>.from(userData.get(USER)));

      Utils.token = user['token'];
      log(Utils.token);

      // Utils.userModel = UserModel.fromJson(Map<String, dynamic>.from(user));

      return userData.get(USER);
    } catch (e) {
      log(e.toString());
      //  userData.clear();
    }
  }

  deleteUserData() async {
    // final userData = await Hive.openBox('dataUser');

    return userData.delete(USER);
  }

  deleteAllData() async {
    final userData = await Hive.openBox('data');

    return userData.delete(USER);
  }

  // Onboarding tracking methods
  Future<void> setOnboardingSeen() async {
    await userData.put(ONBOARDING_SEEN, true);
  }

  Future<bool> hasSeenOnboarding() async {
    return userData.get(ONBOARDING_SEEN, defaultValue: false) ?? false;
  }
}
