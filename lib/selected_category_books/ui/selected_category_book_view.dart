import 'package:book_catalog/Constants/Assets.dart';
import 'package:book_catalog/Constants/Colours.dart';
import 'package:book_catalog/Constants/Dimens.dart';
import 'package:book_catalog/Constants/Fonts.dart';
import 'package:book_catalog/Constants/Strings.dart';
import 'package:book_catalog/common_classes/base_widget.dart';
import 'package:book_catalog/common_classes/view_state.dart';
import 'package:book_catalog/selected_category_books/viewmodel/selected_category_book_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SelectedCategoryBook extends StatefulWidget {
  final String selectedGenre;

  SelectedCategoryBook(this.selectedGenre);

  @override
  _SelectedCategoryBookState createState() => _SelectedCategoryBookState();
}

class _SelectedCategoryBookState extends State<SelectedCategoryBook> {
  SelectedCategoryBookViewModel _viewModel;
  String _searchText = "";
  var _controller = ScrollController();
  var _textController = TextEditingController();

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print("bottom");

      _viewModel.isLoading = true;

      _viewModel.getNextPage(widget.selectedGenre, _searchText, context);
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print("top");
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BaseWidget<SelectedCategoryBookViewModel>(
      onModelReady: (model) => {
        model.getFirstPage(widget.selectedGenre, null, context),
        _viewModel = model,
      },
      builder: (context, model, child) {
        if (model.apiCall.state == ViewState.BUSY && !model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (model.apiCall.isSuccess && model.apiCall.data != null) {
          // _isLoading = false;
          return SafeArea(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(Assets.IC_BACK),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.selectedGenre,
                            style: TextStyle(
                                fontSize: Dimens.SIZE_25,
                                fontFamily: Fonts.FONT_MONTSERRAT_EXTRA_BOLD,
                                color: Color(Colours.COLOUR_5E56E7)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: _textController,
                              cursorColor: Color(Colours.COLOUR_5E56E7),
                              onChanged: (value) {
                                _searchText = value;
                              },
                              decoration: InputDecoration(
                                  //labelText: Strings.BOOK_SEARCH,
                                  hintText: Strings.BOOK_SEARCH,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _textController.clear();
                                      _searchText = "";
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimens.SIZE_4)))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_searchText.isNotEmpty)
                                model.getFirstPage(
                                    widget.selectedGenre.toLowerCase(),
                                    _searchText,
                                    context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.search,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.5,
                          crossAxisSpacing: 10),
                      itemCount: model.apiCall.data.results.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext count, int index) {
                        var book = model.apiCall.data.results[index];
                        String author =
                            (book.authors != null && book.authors.isNotEmpty)
                                ? book.authors[0].name
                                : "Not Found";
                        return GestureDetector(
                          onTap: () {
                            model.openBookLinkInBrowser(context, book.formats);
                          },
                          child: Column(children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Visibility(
                                visible: book.formats.imageJpeg != null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x54000000),
                                          spreadRadius: 4,
                                          blurRadius: 2,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.none,
                                      imageUrl: book.formats.imageJpeg != null
                                          ? book.formats.imageJpeg
                                          : "http://www.gutenberg.org/cache/epub/74/pg74.cover.medium.jpg",
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: book.formats.imageJpeg == null,
                              child: Image(
                                image: AssetImage(Assets.IC_CANCEL),
                              ),
                            ),
                            Text(
                              book.title.toUpperCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: Dimens.SIZE_12,
                                  fontFamily: Fonts.FONT_MONTSERRAT_EXTRA_BOLD,
                                  color: Color(Colours.COLOUR_333333)),
                            ),
                            Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    author,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: Dimens.SIZE_11,
                                        fontFamily: Fonts.FONT_MONTSERRAT_REGULAR,
                                        color: Color(Colours.COLOUR_666666)),
                                  ),
                                ))
                          ]),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: model.isLoading,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text("error");
        }
      },
    ));
  }
}
