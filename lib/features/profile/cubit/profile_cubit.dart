import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/edit_profile/domain/repository/repository.dart';
import 'package:getin_driver/features/profile/domain/model/setting_model.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileRepository profileRepository = locator<ProfileRepository>();
  EditProfileRepository editProfileRepository =
      locator<EditProfileRepository>();
  getUserProfile() async {
    emit(ProfileLoading());
    final response = await editProfileRepository.getProfile();
    if (response != null) {
      Utils.userModel!.totalPoints = response.totalPoints.toString();
      Utils.userModel!.totalStars = response.totalStars.toString();
      Utils.userModel!.range = response.range.toString();
      Utils.userModel!.image = response.image ?? "";
      Utils.userModel!.totalOrdersCompleted = response.totalOrdersCompleted
          .toString();
      emit(ProfileLoaded(response));
    } else {
      emit(ProfileError());
    }
  }

  SiteSettingsModel? siteSettingsModel;
  Future<SiteSettingData?> setting() async {
    if (siteSettingsModel != null) {
      return siteSettingsModel!.data;
    }
    emit(GetSettingDataLoading());
    final response = await profileRepository.getSetting();
    if (response != null) {
      siteSettingsModel = response;
      emit(GetSettingDataLoaded(response.data));
      return response.data;
    } else {
      emit(GetSettingDataError());
      return null;
    }
  }

  Future<bool?> deleteAccount() async {
    final response = await profileRepository.deleteAccount();
    return response;
  }
}
