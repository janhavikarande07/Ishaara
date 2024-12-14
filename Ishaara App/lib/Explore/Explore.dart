import 'package:flutter/material.dart';
import 'package:shreya/Explore/ExploreAlphabets_1.dart';
import 'package:shreya/Explore/ExploreDigits_1.dart';
import 'package:shreya/colors.dart';

class Explore extends StatefulWidget {
  @override
  State<Explore> createState() => ExploreState();
}

class ExploreState extends State<Explore> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  // List of words
  final List<String> words = [
    '1', '2', '3', '4', '5', '6', '7', '8', '9'
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTab = _tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Explore",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontFamily: "Cooper",
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 10),
            Image.asset(
              "assets/bee.png",
              width: 30,
              height: 30,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Material(
                color: lightThemeColor,
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
                  indicatorColor: themeColor,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    _getTab(0, Text("Alphabets", style: TextStyle(fontFamily: "Cooper", fontWeight: FontWeight.w700, fontSize: 20),textAlign: TextAlign.center,)),
                    _getTab(1, Text("Numbers", style: TextStyle(fontFamily: "Cooper", fontWeight: FontWeight.w700, fontSize: 20),textAlign: TextAlign.center,)),
                  ],
                ),
              ),
              Expanded(
                child : Container(
                  color: themeColor,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      _buildAlphabetTab(),
                      _buildWordsTab(),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildAlphabetTab() {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      crossAxisCount: 3,
      mainAxisSpacing: 30.0,
      crossAxisSpacing: 30.0,
      children: List.generate(26, (index) {
        String letter = String.fromCharCode(65 + index);
        return SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExploreAlphabets_1(current_alphabet: letter),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: yellowishOrange,
              elevation: 5,
              padding: EdgeInsets.all(0),
            ),
            child: Text(
              letter,
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Cooper",
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildWordsTab() {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      crossAxisCount: 2,
      mainAxisSpacing: 40.0,
      crossAxisSpacing: 60.0,
      children: words.map((word) {
        return ElevatedButton(
          onPressed: () async {
            print("Selected Digit: $word");
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ExploreDigits_1(current_digit: word),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: yellowishOrange,
            elevation: 5,
            padding: EdgeInsets.all(0),
          ),
          child: Text(word,style: TextStyle(
            fontSize: 24,
            fontFamily: "Cooper",
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),),
        );
      }).toList(),
    );
  }

  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: (_selectedTab == index ? themeColor : lightThemeColor),
              borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab)
      return BorderRadius.only(bottomRight: Radius.circular(10.0));
    else if ((index - 1) == _selectedTab)
      return BorderRadius.only(bottomLeft: Radius.circular(10.0));
    else
      return BorderRadius.zero;
  }
}
