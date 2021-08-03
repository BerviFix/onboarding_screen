import 'package:flutter/material.dart';

class IntroPage {
  IntroPage({required this.title, required this.subtitle, required this.color});

  String title;
  String subtitle;
  Color color;
}

final List<IntroPage> _introPages = [
  IntroPage(
      title: 'The world',
      subtitle:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      color: Colors.blue),
  IntroPage(
      title: 'Is beautiful',
      subtitle:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      color: Colors.indigo),
  IntroPage(
      title: 'You know?',
      subtitle:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      color: Colors.teal),
];

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _selectedPageIndex = 0;

  bool isLastPage() {
    return _selectedPageIndex == _introPages.length - 1;
  }

  void nextPage() {
    if (!isLastPage()) {
      _pageController.animateToPage(_selectedPageIndex + 1,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _introPages[_selectedPageIndex].color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Welcome'),
        centerTitle: true,
        actions: [
          isLastPage()
              ? IconButton(onPressed: nextPage, icon: Icon(Icons.check_circle))
              : IconButton(onPressed: nextPage, icon: Icon(Icons.arrow_forward))
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: onPageChanged,
        itemCount: _introPages.length,
        itemBuilder: (context, index) {
          return IntroPageView(_introPages[index]);
        },
      ),
    );
  }
}

class IntroPageView extends StatelessWidget {
  IntroPageView(this.introPage);
  final IntroPage introPage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
                child: Container(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  Text(introPage.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    introPage.subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )))
      ],
    );
  }
}
