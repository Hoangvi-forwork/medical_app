import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medical_app/blocs/news/news_bloc.dart';
import 'package:medical_app/model/news_model.dart';
import 'package:medical_app/repositories/news_repositories.dart';
import 'package:medical_app/views/news/news_detail.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../widgets/buttons/bottom_navigation_bar_widget.dart';
import '../../widgets/draw.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final videoURL = 'https://youtu.be/xXH-vHY7Ifw';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: true,
          loop: false,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: const buildDrawer(),
      body: BlocProvider(
        create: (context) => NewsBloc(
          NewsRepository(),
        )..add(
            NewsLoadEvent(),
          ),
        child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
          if (state is NewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
          if (state is NewsLoadedState) {
            List<NewsModel> newsList = state.newsList;
            return _newsBody(newsList);
          }
          return Container();
        }),
      ),
      bottomNavigationBar: const buildBottomNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("News"),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
    );
  }

  SingleChildScrollView _newsBody(List<NewsModel> newsList) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top News
          _topNewsVideo(),
          //
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: const Divider(
              height: 1,
              color: Colors.black,
            ),
          ),
          // News
          _titleContent(),
          //
          Container(
            margin: const EdgeInsets.only(bottom: 46),
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                Color backgroundColor = (index % 2) != 0
                    ? Colors.grey.withOpacity(0.2)
                    : Colors.white.withOpacity(0.7);

                return Slidable(
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          // print("Add to Favorite");
                        },
                        backgroundColor: Colors.green,
                        icon: Icons.favorite,
                        label: "Save",
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          // print("Add to Favorite");
                        },
                        backgroundColor: Colors.blue,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          // print("Delete");
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete_outline,
                        label: 'Hạn chế',
                      ),
                    ],
                  ),
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      // bottom: 6,
                    ),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: SizedBox(
                            width: 66,
                            height: 66,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                newsList[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              newsList[index].title.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            newsList[index].content,
                            maxLines: 2,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDatailScreen(
                                  title: newsList[index].title,
                                  content: newsList[index].content,
                                  imageUrl: newsList[index].imageUrl,
                                  postTime: newsList[index].timestamp.toDate(),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _titleContent() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: const Text(
        "Tin Mới: ",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Colors.black,
        ),
      ),
    );
  }

  Column _topNewsVideo() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 0),
          width: double.infinity,
          height: 220,
          color: Colors.grey,
          child: Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () => debugPrint('Ready'),
              bottomActions: [
                CurrentPosition(),
                ProgressBar(
                  isExpanded: true,
                  colors: const ProgressBarColors(
                    playedColor: Colors.red,
                    handleColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: Column(
            children: [
              const Text(
                "Tình hình dịch bệnh đang dần chuyển biến phức tạp",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '12:30 22.09.2023',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Báo Thanh Niên',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
