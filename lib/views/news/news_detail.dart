import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_app/widgets/buttons/bottom_navigation_bar_widget.dart';
import 'package:medical_app/widgets/colors.dart';
import 'package:medical_app/widgets/draw.dart';

class NewsDatailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;
  final DateTime postTime;
  const NewsDatailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.postTime,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> textParagraphs = content.trim().split('.');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("News"),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      endDrawer: const buildDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: GoogleFonts.poppins().toString(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    postTime.toString(),
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, bottom: 24),
                child: const Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Text(
                textParagraphs[0].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().toString(),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Column(
                children: textParagraphs
                    .sublist(
                        1) // Bỏ qua đoạn văn bản đầu tiên vì đã được hiển thị trước đó
                    .map((paragraph) => Text(
                          paragraph,
                          style: TextStyle(
                            fontFamily: GoogleFonts.poppins().toString(),
                            height: 1.5,
                          ),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const buildBottomNavigationBar(),
    );
  }
}
