import 'package:getin_driver/features/profile/domain/model/setting_model.dart';

import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => ProfileRepository(locator<DioService>()));
//  import '../../modules/profile/domain/repository/repository.dart';
class ProfileRepository {
  final DioService dioService;
  ProfileRepository(this.dioService);
  Future<SiteSettingsModel?> getSetting() async {
    try {
      final response = await dioService.getData(url: "site-settings");
      if (response.isError == false) {
        return SiteSettingsModel.fromJson(response.response?.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool?> deleteAccount() async {
    try {
      final response = await dioService.deleteData(
        url: "delete-account",
        loading: true,
      );
      if (response.isError == false) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
