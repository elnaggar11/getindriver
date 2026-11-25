import 'package:getin_driver/core/data_source/cached_page_helper.dart';
import 'package:getin_driver/core/data_source/dio_helper.dart';
import 'package:getin_driver/features/support/domain/model/support_model.dart';

class SupportRepository {
  static const String _supportCacheKey = 'cached_driver_support_v1';

  final DioService dio;

  SupportRepository(this.dio);

  Future<CachedPageResult<SupportModel>> getSupport() {
    return fetchCachedPage<SupportModel>(
      dio: dio,
      url: 'driver/support',
      cacheKey: _supportCacheKey,
      fromJson: SupportModel.fromJson,
    );
  }
}
