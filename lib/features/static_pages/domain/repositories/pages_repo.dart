import 'package:getin_driver/core/data_source/cached_page_helper.dart';
import 'package:getin_driver/core/data_source/dio_helper.dart';
import 'package:getin_driver/features/static_pages/domain/models/terms_model.dart';

class StaticRepositories {
  static const String _termsCacheKey = 'cached_driver_terms_v1';
  static const String _privacyPolicyCacheKey =
      'cached_driver_privacy_policy_v1';

  final DioService dio;

  StaticRepositories(this.dio);

  Future<CachedPageResult<TermsModel>> gettermspage() {
    return fetchCachedPage<TermsModel>(
      dio: dio,
      url: 'driver/terms-conditions',
      cacheKey: _termsCacheKey,
      fromJson: TermsModel.fromJson,
    );
  }

  Future<CachedPageResult<TermsModel>> getPrivacyPolicyPage() {
    return fetchCachedPage<TermsModel>(
      dio: dio,
      url: 'driver/privacy-policy',
      cacheKey: _privacyPolicyCacheKey,
      fromJson: TermsModel.fromJson,
    );
  }
}
