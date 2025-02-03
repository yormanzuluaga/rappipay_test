import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rappipay_test/app/routes/routes_names.dart';
import 'package:rappipay_ui/rappipay_ui.dart';

class Detail extends StatelessWidget {
  const Detail({
    super.key,
    required this.title,
    required this.url,
    required this.descripto,
  });

  final String title;
  final String url;
  final String descripto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go(RoutesNames.home);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: UITextStyle.titles.title2Medium,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: AppSpacing.lg,
          ),
          Image.network(url),
          SizedBox(
            height: AppSpacing.lg,
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  descripto,
                  style: UITextStyle.paragraphs.paragraph1Regular,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
