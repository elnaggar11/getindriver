import 'package:getin_driver/features/edit_profile/domain/model/profile.dart';

abstract class EditProfileStates {}

class EditProfileInitial extends EditProfileStates {}

class GetProfileLoadingState extends EditProfileStates {}

class GetProfileSuccessState extends EditProfileStates {
  final MyProfileModel profile;
  GetProfileSuccessState({required this.profile});
}

class GetProfileErrorState extends EditProfileStates {}

class UpdateProfileLoadingState extends EditProfileStates {}

class UpdateProfileSuccessState extends EditProfileStates {}

class UpdateProfileErrorState extends EditProfileStates {}
