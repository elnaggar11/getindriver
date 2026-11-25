import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getin_driver/features/auth/domain/model/auth_model.dart';
import 'dart:io';
import 'dart:math' as math;
import '../data_source/hive_helper.dart';
import '../services/media/my_media.dart';
import 'Locator.dart';
import 'validations.dart';

class Utils {
  static String token = '';
  static String lang = '';
  static String FCMToken = '';
  static String userType = "";
  static UserModel? userModel;
  static GlobalKey<NavigatorState> navigatorKey() =>
      locator<GlobalKey<NavigatorState>>();
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static Validation get valid => locator<Validation>();
  static MediaService get media => locator<MediaService>();
  static DataManager get dataManager => locator<DataManager>();

  static saveUserInHive(Map<String, dynamic> response) async {
    userModel = UserModel.fromJson(response);
    token = userModel?.accessToken ?? '';
    await Utils.dataManager.saveUser(Map<String, dynamic>.from(response));
  }

  static void clearUser() async {
    userModel = null;
    token = '';
    await Utils.dataManager.clearUser();
  }

  static Future<UserModel?> getUser() async {
    if (userModel != null) {
      return userModel;
    }
    userModel = await Utils.dataManager.getuser();
    token = userModel?.accessToken ?? '';
    log(token, name: 'token');
    return userModel;
  }

  static void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  static void fixRtlLastChar(TextEditingController? controller) {
    if (controller != null) {
      if (controller.selection ==
          TextSelection.fromPosition(
            TextPosition(offset: (controller.text.length) - 1),
          )) {
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
    }
  }

  static genrateBarcode() {
    return (math.Random().nextInt(99999999) + 10000000).toString();
  }

  static double getSizeOfFile(File file) {
    final size = file.readAsBytesSync().lengthInBytes;
    final kb = size / 1024;
    final mb = kb / 1024;
    print(mb);
    return mb;
  }
}

extension MySLiverBox on Widget {
  // SliverToBoxAdapter get SliverBox => SliverToBoxAdapter(
  //   child: this,
  // );
  /*  SliverToBoxAdapter get SliverBoxAnimation => SliverToBoxAdapter(
    child: Padding(
      padding:  EdgeInsets.all(16),
      child: this,
    ),
  ); */
}
