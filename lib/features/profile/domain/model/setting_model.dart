class SiteSettingsModel {
  final bool status;
  final String message;
  final SiteSettingData data;

  SiteSettingsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SiteSettingsModel.fromJson(Map<String, dynamic> json) {
    return SiteSettingsModel(
      status: json['status'],
      message: json['message'],
      data: SiteSettingData.fromJson(json['data']),
    );
  }
}

class SiteSettingData {
  final String title;
  final String description;
  final String image;
  final String appLinkGooglePlay;
  final String appLinkAppStore;

  SiteSettingData({
    required this.title,
    required this.description,
    required this.image,
    required this.appLinkGooglePlay,
    required this.appLinkAppStore,
  });

  factory SiteSettingData.fromJson(Map<String, dynamic> json) {
    return SiteSettingData(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      appLinkGooglePlay: json['app_link_google_play'],
      appLinkAppStore: json['app_link_app_store'],
    );
  }
}
