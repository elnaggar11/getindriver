import 'dart:convert';

import 'package:getin_driver/core/data_source/dio_helper.dart';
import 'package:getin_driver/core/utils/utils.dart';

/// Result of fetching a public CMS page with offline cache fallback.
class CachedPageResult<T> {
  final T? data;
  final String? errorMessage;

  const CachedPageResult({this.data, this.errorMessage});
}

/// Fetches a CMS page from [url], caches its JSON payload under [cacheKey]
/// on success, and falls back to the last cached response if offline or failing.
Future<CachedPageResult<T>> fetchCachedPage<T>({
  required DioService dio,
  required String url,
  required String cacheKey,
  required T Function(Map<String, dynamic>) fromJson,
}) async {
  final ApiResponse response = await dio.getData(url: url, loading: false);

  if (!response.isError) {
    final rawData = response.response?.data?['data'];
    if (rawData is Map) {
      final map = Map<String, dynamic>.from(rawData);
      await Utils.dataManager.saveData(cacheKey, jsonEncode(map));
      return CachedPageResult<T>(data: fromJson(map));
    }
  }

  final cachedRaw = await Utils.dataManager.getData(cacheKey);
  if (cachedRaw is String && cachedRaw.isNotEmpty) {
    try {
      final decoded = jsonDecode(cachedRaw);
      if (decoded is Map) {
        return CachedPageResult<T>(
          data: fromJson(Map<String, dynamic>.from(decoded)),
        );
      }
    } catch (_) {
      // Ignore corrupted cache and surface the server/network error instead.
    }
  }

  return CachedPageResult<T>(errorMessage: response.message);
}
