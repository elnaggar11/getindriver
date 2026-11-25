import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getin_driver/core/data_source/cached_page_helper.dart';
import 'package:getin_driver/core/data_source/dio_helper.dart';
import 'package:getin_driver/core/utils/Locator.dart';
import 'package:getin_driver/features/static_pages/domain/models/terms_model.dart';
import 'package:getin_driver/features/static_pages/domain/repositories/pages_repo.dart';

part 'staticpage_state.dart';

class StaticpageCubit extends Cubit<StaticpageState> {
  StaticpageCubit() : super(StaticpageInitial());

  final StaticRepositories _staticRepositories = StaticRepositories(
    locator<DioService>(),
  );

  Future<void> getTermsScreen() => _loadPage(_staticRepositories.gettermspage);

  Future<void> getPrivacyPolicyScreen() =>
      _loadPage(_staticRepositories.getPrivacyPolicyPage);

  Future<void> _loadPage(
    Future<CachedPageResult<TermsModel>> Function() loader,
  ) async {
    emit(GetTermsLoading());
    try {
      final result = await loader();
      if (result.data != null) {
        emit(GetTermsSucess(terms: result.data!));
      } else {
        emit(GetTermsFailed(message: result.errorMessage));
      }
    } catch (_) {
      emit(const GetTermsFailed());
    }
  }
}
