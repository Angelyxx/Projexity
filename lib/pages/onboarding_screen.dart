import 'package:flutter/material.dart';
import 'package:projexity/pages/home_page.dart';
import 'package:projexity/pages/qna_screens/dob_page.dart';
import 'package:projexity/pages/qna_screens/interest_page.dart';
import 'package:projexity/pages/qna_screens/name_page.dart';
import 'package:projexity/pages/qna_screens/skills_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //Controller to keep track of pages
  PageController _controller = PageController();

  // Keep track if we're on the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 3);
            });
          },
          children: [
            NamePage(),
            DobPage(),
            InterestPage(),
            SkillsPage(),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                IconButton(
                    onPressed: () {
                      _controller.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    icon: const Icon(Icons.arrow_circle_left)),

                //dot indicator
                SmoothPageIndicator(controller: _controller, count: 4),

                //Next / done button
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage(); //Go to explore page
                          }));
                        },
                        child: Text('done'))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('next')),
              ],
            ))
      ],
    ));
  }
}
