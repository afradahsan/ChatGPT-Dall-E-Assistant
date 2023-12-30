import 'package:chatgpt/view/constants/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController prompt = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    print(screenHeight);

    return Scaffold(
      backgroundColor: Palette.gptbackground,
      appBar: AppBar(title: const Text('ChatGPT', style: TextStyle(color: Colors.white),), centerTitle: true, backgroundColor: Palette.transparent, elevation: 0,),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        height: screenHeight/15,
                        width: screenWidth/1.27,
                        child: TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.lightgrey)
                            ),
                          ),
                          controller: prompt,
                        ),
                      ),
                      SizedBox(width: screenWidth/30,),
                      Container(
                        height: screenHeight/25.6,
                        width: screenHeight/25.6,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Icon(Icons.mic, color: Palette.gptbackground, size: 10,)),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}