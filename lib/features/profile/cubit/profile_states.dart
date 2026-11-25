import 'package:getin_driver/features/edit_profile/domain/model/profile.dart';
import 'package:getin_driver/features/profile/domain/model/setting_model.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}


      class ProfileLoading extends ProfileStates {}
      
    class ProfileLoaded extends ProfileStates {
      final MyProfileModel? response;
    
      ProfileLoaded(this.response);
    }
    
      class ProfileError extends ProfileStates {}
      

      class GetSettingDataLoading extends ProfileStates {}
      
    class GetSettingDataLoaded extends ProfileStates {
      final SiteSettingData response;
    
      GetSettingDataLoaded(this.response);
    }
    
      class GetSettingDataError extends ProfileStates {}
      