import 'package:book_catalog/common_classes/base_viewmodel.dart';
import 'package:book_catalog/common_classes/locator.dart';
import 'package:book_catalog/model/dashboard_model.dart';
import 'package:book_catalog/repository/dashboard_repository.dart';

class DashboardViewModel extends BaseViewModel {
  DashboardRepository _dashboardRepository = locator<DashboardRepository>();

  DashboardModel getCategorieData() {
    return _dashboardRepository.getCategoryData();
  }
}
