import 'package:book_catalog/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:book_catalog/repository/dashboard_repository.dart';
import 'package:book_catalog/repository/selected_category_repository.dart';
import 'package:book_catalog/selected_category_books/viewmodel/selected_category_book_viewmodel.dart';
import 'package:get_it/get_it.dart';

import 'base_repository.dart';
GetIt locator=GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(()=>BaseRepository());
  locator.registerFactory(() => DashboardRepository());
  locator.registerFactory(() => DashboardViewModel());
  locator.registerFactory(() => SelectedCategoryRepository());
  locator.registerFactory(() => SelectedCategoryBookViewModel());
}