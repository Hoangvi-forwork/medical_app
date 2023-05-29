import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:medical_app/widgets/draw.dart';
import '../widgets/buttons/bottom_navigation_bar_widget.dart';
import '../widgets/buttons/floating_scroll_button.dart';
import '../widgets/text_title_and_subtitle.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // ignore: non_constant_identifier_names
  final imagePosterList = [
    // 'https://i.pinimg.com/564x/be/40/82/be40821440e028c7ab9465129451ec1a.jpg',
    'https://i.pinimg.com/564x/dc/15/34/dc153450c183e09c795ec34ffcaa41df.jpg',
    'https://mir-s3-cdn-cf.behance.net/project_modules/fs/4c2b42168190377.643650b6b60d9.jpg',
    'https://i.pinimg.com/564x/d4/db/9e/d4db9e013b00ff3923767140b9f6e4ab.jpg',
    'https://i.pinimg.com/564x/80/09/b9/8009b9424e102c934afe2a3386b7d817.jpg',
    'https://i.pinimg.com/564x/34/05/e5/3405e5769a09dac6b28893ad465d16df.jpg',
  ];
  Map<String, dynamic> iconsList = {
    'policlinic': 'assets/icons/stethoscope.png',
    'emergency': 'assets/icons/hospital.png',
    'vaccination': 'assets/icons/injection.png',
    'medicine': 'assets/icons/capsules.png',
    'heart': 'assets/icons/cardiogram.png',
    'bloodtest': 'assets/icons/blood-test.png'
  };

  List<Map<String, dynamic>> newDiseaseList = [
    {
      "url":
          "https://login.medlatec.vn//ImagePath/images/20200824/20200824_Cam-lanh-1.jpg",
      "diseaseName": "Cảm lạnh",
      "indentificationSign": "Hắt hơi, sổ mũi, đau họng, ho, sốt nhẹ.",
      "diseaseObject": "Trẻ em và người già",
    },
    {
      "url":
          "https://tamanhhospital.vn/wp-content/uploads/2022/07/tac-nhan-gay-benh-sot-ret.jpg",
      "diseaseName": "Sốt rét",
      "indentificationSign": "Sốt, đau đầu, buồn nôn, co giật, mất ý thức",
      "diseaseObject": "Trẻ em và người già",
    },
    {
      "url":
          "https://tamanhhospital.vn/wp-content/uploads/2021/09/nguyen-nhan-gay-viem-phoi.jpg",
      "diseaseName": "Viêm phổi",
      "indentificationSign": "Sốt, ho khan, khó thở, đau ngực",
      "diseaseObject": "Người già",
    },
    {
      "url":
          "https://hanoimoi.com.vn/Uploads/images/tuandiep/2019/08/13/Khong-tai-dan-o-nhung-co-so.jpg",
      "diseaseName": "Bệnh dịch tả",
      "indentificationSign": "Sốt, nôn ói, tiêu chảy, đau bụng",
      "diseaseObject": "Trẻ em và người già",
    },
    {
      "url":
          "https://bcp.cdnchinhphu.vn/thumb_w/640/334894974524682240/2023/3/20/sxh-1679285610784870118864.jpg",
      "diseaseName": "Sốt xuất huyết",
      "indentificationSign": "Sốt, đau đầu, đau mắt, đau khớp, chảy máu nhiều",
      "diseaseObject": "Trẻ em và người già",
    },
  ];

  final ScrollController scrollController = ScrollController();
  bool isVisibale = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      //
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          isVisibale = false;
        });
      }
      //
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          isVisibale = true;
        });
      }
      //
    });

    @override
    void dispose() {
      scrollController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu_sharp,
            color: AppColors.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColors.primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      drawer: const buildDrawer(),
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16),
        width: double.infinity,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _topListViewPoster(imagePosterList),
              const textTitleAndSubTitle(
                textTitle: 'Service List',
                subTitle: 'Select the service you want to consult',
              ),
              _serviceListIcons(iconsList),
              const textTitleAndSubTitle(
                textTitle: 'Common diseases',
                subTitle: 'Be careful with the change of weather',
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newDiseaseList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 86,
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.2),
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: ListTile(
                          onTap: (() {
                            // showBottomSheet(
                            //   context: context,
                            //   builder: (context) {
                            //     return Container(
                            //       width: double.infinity,
                            //       height: 360,
                            //       decoration: const BoxDecoration(
                            //         color: AppColors.primaryColor,
                            //         borderRadius: BorderRadius.only(
                            //           topLeft: Radius.circular(12),
                            //           topRight: Radius.circular(12),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
                          }),
                          leading: Container(
                            width: 66,
                            height: 66,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                newDiseaseList[index]['url'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            newDiseaseList[index]['diseaseName'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            newDiseaseList[index]['indentificationSign'],
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic),
                          ),
                          trailing: const Icon(Icons.arrow_right),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: BuildFloatingActionScrollButton(
        isVisibale: isVisibale,
        scrollController: scrollController,
      ),
      bottomNavigationBar: const buildBottomNavigationBar(),
    );
  }

  Container _serviceListIcons(Map<String, dynamic> iconsList) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.only(top: 12),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: iconsList.length,
          itemBuilder: (context, index) {
            String key = iconsList.keys.elementAt(index);
            String value = iconsList[key];
            return GestureDetector(
              onTap: () {
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.white,
                      content: Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('Dịch vụ chưa khả dụng'),
                      ),
                    ),
                  );
                });
              },
              child: Container(
                width: 56,
                height: 56,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  value,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }

  SizedBox _topListViewPoster(List<String> imagePosterList) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 354,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imagePosterList[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
