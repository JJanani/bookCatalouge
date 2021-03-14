class DashboardModel {
  final List<CategoryData> categoryList;

  DashboardModel({this.categoryList});
}

class CategoryData {
  final String categoryTitle;
  final String categoryImage;
  CategoryData({this.categoryTitle, this.categoryImage});
}
