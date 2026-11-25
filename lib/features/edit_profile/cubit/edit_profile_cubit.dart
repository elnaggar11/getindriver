
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/utils/utils.dart';
import 'package:getin_driver/features/edit_profile/domain/model/edit_profile_model.dart';
import 'package:getin_driver/features/edit_profile/domain/model/profile.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'edit_profile_states.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitial());
  static EditProfileCubit get(context) => BlocProvider.of(context);

  EditProfileRepository editProfileRepository =
      locator<EditProfileRepository>();

  MyProfileModel? profile;
  Future<void> getProfile() async {
    emit(GetProfileLoadingState());
    final response = await editProfileRepository.getProfile();
    
    if (response != null) {
      profile = response;
      emit(GetProfileSuccessState(profile: response));
    } else {
      emit(GetProfileErrorState());
    }
  }

  Future<void> updateProfile(EditProfileModel editProfileModel) async {
    emit(UpdateProfileLoadingState());
    final response = await editProfileRepository.updateProfile(
      editProfileModel,
    );
    if (response != null) {
      response["data"]["access_token"] = Utils.token;
      Utils.saveUserInHive(response["data"]);
      
      emit(UpdateProfileSuccessState());
    } else {
      emit(UpdateProfileErrorState());
    }
  }
}
