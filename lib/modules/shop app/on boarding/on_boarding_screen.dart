import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mansour_/modules/news/network/local/cash_helper.dart';
import 'package:mansour_/modules/shop%20app/login/shop_login_screen.dart';
import 'package:mansour_/modules/shop%20app/sharedPreferences.dart/cash_helper.dart';
import 'package:mansour_/shared/components/constans.dart';
import 'package:mansour_/shared/components/copmonents.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  // const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> list = [
    BoardingModel(
        image: 'images/pageview1.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'),
    BoardingModel(
        image: 'images/img.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'),
    BoardingModel(
        image: 'images/pageview1.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'),
  ];

  var boardController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [defaultTextButton(text: 'SKIP', onPressed: () => submit())],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                  onPageChanged: (index) {
                    if (list.length - 1 == index) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(list[index]),
                  itemCount: list.length,
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: list.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotWidth: 10,
                        dotHeight: 10,
                        expansionFactor: 4,
                        spacing: 5,
                        activeDotColor: defaultColor),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel boardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(boardingModel.image))),
          SizedBox(height: 30),
          Text(
            boardingModel.title,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 15),
          Text(
            boardingModel.body,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(height: 15),
        ],
      );

  void submit() {
    CashHelperShop.saveData(key: 'onBoarding', value: true).then((value) => {
          if (true) {navigateAndFinish(context, ShopLoginScreen())}
        });
  }
}
