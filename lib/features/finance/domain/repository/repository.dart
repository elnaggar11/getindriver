import '../model/finance_model.dart';
import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => FinanceRepository(locator<DioService>()));
//  import '../../modules/finance/domain/repository/repository.dart';
class FinanceRepository {
  final DioService dioService;
  FinanceRepository(this.dioService);
  Future<FinanceModel?> getFinance(
    String status,
    String currentSearch, {
    int page = 1,
  }) async {
    final response = await dioService.getData(
      url: "driver/finance/$status",
      query: {"order_num": currentSearch, "page": page},
    );
    if (response.isError == false) {
      return FinanceModel.fromJson(response.response?.data);
    } else {
      return null;
    }
  }
}
