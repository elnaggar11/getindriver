import 'package:getin_driver/features/edit_profile/domain/model/profile.dart';


import '../model/edit_profile_model.dart';
import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => EditProfileRepository(locator<DioService>()));
//  import '../../modules/edit_profile/domain/repository/repository.dart';
class EditProfileRepository {
  final DioService dioService;
  EditProfileRepository(this.dioService);
  Future<MyProfileModel?> getProfile() async {
    final response = await dioService.getData(
      url: "driver/profile",
      parser: (data) => MyProfileModel.fromJson(data['data']),
    );
    if (response.isError == false) {
      return response.model;
    } else {
      return null;
    }
  }

  Future<dynamic> updateProfile(EditProfileModel editProfileModel) async {
    final response = await dioService.postData(
      url: "driver/profile/update",
      body: await editProfileModel.toJson(),
      loading: true,
      isForm: true,
      isFile: true,
      // parser: (data) => MyProfileModel.fromJson(data),
    );
    if (response.isError == false) {
      return response.response?.data;
    } else {
      return null;
    }
  }
}
