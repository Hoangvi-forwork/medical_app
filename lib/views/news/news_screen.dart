// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:medical_app/blocs/news/news_bloc.dart';
import 'package:medical_app/blocs/news/news_event.dart';
import 'package:medical_app/blocs/news/news_state.dart';
import 'package:medical_app/model/news_model.dart';
import 'package:medical_app/repositories/news_repositories.dart';
import 'package:medical_app/widgets/colors.dart';
import '../../utils/container_utils.dart';
import '../../widgets/buttons/floating_scroll_button.dart';
import 'news_detail.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();
  bool isVisibale = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(
          () {
            isVisibale = false;
          },
        );
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          isVisibale = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 24, bottom: 12),
          child: BlocProvider(
            create: (context) => NewsBloc(
              NewRepositories(),
            )..add(
                FetchNewsEvent(),
              ),
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoadingState) {
                  return ContainerUtils.loadingStateContainer0;
                } else if (state is NewsErrorState) {
                  return Container(
                    margin: const EdgeInsets.all(24),
                    child: ContainerUtils.loadingErrorStateContainer,
                  );
                } else if (state is NewsLoadedState) {
                  List<NewsModel> newsList = state.newsList;
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: newsList.length,
                      itemBuilder: (context, index) => NewsItem(
                        newsModel: newsList[index],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
      floatingActionButton: BuildFloatingActionScrollButton(
        isVisibale: isVisibale,
        scrollController: scrollController,
      ),
    );
  }
}

class NewsItem extends StatefulWidget {
  final NewsModel newsModel;

  const NewsItem({required this.newsModel, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        height: isExpanded ? 550 : 120, // Update the expanded height
        width: double.infinity,
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.75,
            ),
          ),
        ),
        child: isExpanded
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.newsModel.hinhAnh.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            widget.newsModel.tieuDe.toString().toUpperCase(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Html(
                            data: widget.newsModel.noiDung!.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onLongPress: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDatailScreen(
                        title: widget.newsModel.tieuDe!.toString(),
                        content: widget.newsModel.noiDung!.toString(),
                        imageUrl: widget.newsModel.hinhAnh!.toString(),
                        postTime: null,
                      ),
                    ),
                  );
                }),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Image.network(
                            widget.newsModel.hinhAnh.toString(),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ), // Add some space between image and content
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.newsModel.tieuDe.toString().toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.newsModel.gioiThieu.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
