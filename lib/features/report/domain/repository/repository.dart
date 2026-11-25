import '../model/report_model.dart';
import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => ReportRepository(locator<DioService>()));
//  import '../../modules/report/domain/repository/repository.dart';
class ReportRepository {
  final DioService dioService;
  ReportRepository(this.dioService);

  Future<ReviewsPagination?> getReviews(int? page) async {
    final ApiResponse response = await dioService.getData(
      url: 'driver/reviews',
      query: {"page": page},
    );
    if (response.isError == false) {
      return ReviewsPagination.fromJson(response.response?.data);
    } else {
      return null;
    }
  }
}
