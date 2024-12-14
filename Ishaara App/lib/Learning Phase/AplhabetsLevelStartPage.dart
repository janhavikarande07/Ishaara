import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../values_.dart';
import 'a_Q1.dart';

import '../colors.dart';

class AlphabetsLevelStartPage extends StatefulWidget {
  final int current_level;
  const AlphabetsLevelStartPage({Key? key, required this.current_level}) : super(key: key);
  @override
  State<AlphabetsLevelStartPage> createState() => AlphabetsLevelStartPageState();
}

class AlphabetsLevelStartPageState extends State<AlphabetsLevelStartPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.current_level);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body :
      Container(
        alignment: Alignment.center,
      child : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeColor,
              boxShadow: [
                BoxShadow(
                  color: themeColor.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${widget.current_level}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 50,),
          Text("Alphabets",
          style: TextStyle(
            fontFamily: "Cooper",
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  learning_alphabets_levels["${widget.current_level}"] >= 0 ?
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          A_Q1(current_alphabet: alphabets_map["${widget
                              .current_level}"][0],
                              current_level: widget.current_level),
                    ),
                  ) : null;
                },
                child: Stack(
                  children: [
                    learning_alphabets_levels["${widget.current_level}"] >= 0 ?
                    Image.asset(
                      'assets/level_bg.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ) :
                    Image.asset(
                      'assets/level_disable_bg.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    // Centered text
                    Positioned.fill(
                      child: learning_alphabets_levels["${widget.current_level}"] >= 1 ?
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Image.asset("assets/tick.png", width: 50, height: 50,)
                              ),
                            Positioned.fill(
                              child: Center(
                                child: Text(
                                  '${alphabets_map["${widget.current_level}"][0]}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  textAlign: TextAlign.center,
                                  ),
                              ),
                            )
                          ],
                        ),
                      ) :
                      Center(
                        child: Text(
                          '${alphabets_map["${widget.current_level}"][0]}',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 50),
              GestureDetector(
                onTap: () {
                learning_alphabets_levels["${widget.current_level}"] >= 1 ?
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => A_Q1(current_alphabet : alphabets_map["${widget.current_level}"][1], current_level : widget.current_level),
                    ),
                  ) : null;
                },
                  child: Stack(
                  children: [
                  learning_alphabets_levels["${widget.current_level}"] >= 1 ?
                  Image.asset(
                    'assets/level_bg.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ) :
                  Image.asset(
                    'assets/level_disable_bg.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                    ),
                    // Centered text
                    Positioned.fill(
                      child: learning_alphabets_levels["${widget.current_level}"] >= 2 ?
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                child: Image.asset("assets/tick.png", width: 50, height: 50,)
                            ),
                            Positioned.fill(
                              child: Center(
                                child: Text(
                                  '${alphabets_map["${widget.current_level}"][1]}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),
                      ) :
                      Center(
                        child: Text(
                          '${alphabets_map["${widget.current_level}"][1]}',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              learning_alphabets_levels["${widget.current_level}"] >= 2 ?
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      A_Q1(current_alphabet: alphabets_map["${widget
                          .current_level}"][2],
                          current_level: widget.current_level),
                ),
              ) : null;
            },
            child: Stack(
              children: [
                learning_alphabets_levels["${widget.current_level}"] >= 2 ?
                Image.asset(
                  'assets/level_bg.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ) :
                Image.asset(
                  'assets/level_disable_bg.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                // Centered text
                Positioned.fill(
                  child: learning_alphabets_levels["${widget.current_level}"] >= 3 ?
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            child: Image.asset("assets/tick.png", width: 50, height: 50,)
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              '${alphabets_map["${widget.current_level}"][2]}',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ) :
                  Center(
                    child: Text(
                      '${alphabets_map["${widget.current_level}"][2]}',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
      ),
    );
  }
}