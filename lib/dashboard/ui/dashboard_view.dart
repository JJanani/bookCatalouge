import 'package:book_catalog/Constants/Assets.dart';
import 'package:book_catalog/Constants/Colours.dart';
import 'package:book_catalog/Constants/Dimens.dart';
import 'package:book_catalog/Constants/Fonts.dart';
import 'package:book_catalog/Constants/Strings.dart';
import 'package:book_catalog/common_classes/base_widget.dart';
import 'package:book_catalog/common_widgets/check_internet_dialog.dart';
import 'package:book_catalog/common_widgets/common_dialog.dart';
import 'package:book_catalog/dashboard/viewmodel/dashboard_viewmodel.dart';

import 'package:book_catalog/model/dashboard_model.dart';
import 'package:book_catalog/selected_category_books/ui/selected_category_book_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  BuildContext _mContext;

  @override
  Widget build(BuildContext context) {
    _mContext = context;
    return Scaffold(
      body: BaseWidget<DashboardViewModel>(
        onModelReady: (model) => model.getCategorieData(),
        builder: (context, model, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Strings.APP_NAME,
                      style: TextStyle(
                          fontSize: Dimens.SIZE_48,
                          fontFamily: Fonts.FONT_MONTSERRAT_SEMI_BOLD,
                          color: Color(Colours.COLOUR_5E56E7)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Strings.DASHBOARD_HEADING,
                      style: TextStyle(
                          fontSize: Dimens.SIZE_18,
                          fontFamily: Fonts.FONT_MONTSERRAT_SEMI_BOLD,
                          color: Color(Colours.COLOUR_333333)),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.getCategorieData().categoryList.length,
                      itemBuilder: (context, index) => _getCategoryItem(
                          index, model.getCategorieData(), context))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void dismissDialog() {
    Navigator.pop(_mContext);
  }

  Widget _getCategoryItem(
      int index, DashboardModel dashboardModel, BuildContext context) {
    return GestureDetector(
      onTap: () {
        isConnected().then((value) => {
              if (value)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectedCategoryBook(
                                dashboardModel.categoryList[index].categoryTitle,
                              )))
                }
              else
                {
                  CommonDialog.showDialogWithOkButton(
                      context,
                      Strings.INTERNET_CONNECTION_HEADING,
                      Strings.INTERNET_CONNECTION_DESCRIPTION,
                      dismissDialog )
                }
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(Colours.COLOUR_FFFFFF),
            borderRadius: BorderRadius.circular(Dimens.SIZE_3),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      dashboardModel.categoryList[index].categoryImage,
                      height: Dimens.SIZE_35,
                      width: Dimens.SIZE_35,
                      //color: Color(Colours.COLOUR_5E56E7),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      dashboardModel.categoryList[index].categoryTitle.toUpperCase(),
                      style: TextStyle(
                          color: Color(Colours.COLOUR_000000),
                          fontSize: Dimens.SIZE_20,
                          fontFamily: Fonts.FONT_MONTSERRAT_REGULAR),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(Assets.IC_NEXT),
              )
            ],
          ),
        ),
      ),
    );
  }
}
