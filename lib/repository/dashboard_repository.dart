import 'package:book_catalog/Constants/Assets.dart';
import 'package:book_catalog/Constants/Strings.dart';
import 'package:book_catalog/common_classes/base_repository.dart';
import 'package:book_catalog/model/dashboard_model.dart';

class DashboardRepository extends BaseRepository {
  DashboardModel _dashboardCategoriesData = DashboardModel(categoryList: [
    CategoryData(categoryTitle: Strings.FICTION, categoryImage: Assets.IC_FICTION),
    CategoryData(categoryTitle: Strings.DRAMA, categoryImage:Assets.IC_DRAMA),
    CategoryData(categoryTitle: Strings.HUMOR, categoryImage: Assets.IC_HUMOUR),
    CategoryData(categoryTitle: Strings.POLITICS, categoryImage: Assets.IC_POLITICS),
    CategoryData(categoryTitle: Strings.PHILOSOPHY, categoryImage: Assets.IC_PHILOSOPHY),
    CategoryData(categoryTitle: Strings.HISTORY, categoryImage: Assets.IC_HISTORY),
    CategoryData(categoryTitle: Strings.ADVENTURE, categoryImage: Assets.IC_ADVENTURE)
  ]);

  DashboardModel getCategoryData(){
    return _dashboardCategoriesData;

  }
}
