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
    return Scaffold(
      backgroundColor: Palette.gptbackground,
      appBar: AppBar(title: const Text('ChatGPT', style: TextStyle(color: Colors.white),), centerTitle: true, backgroundColor: Palette.transparent, elevation: 0,),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.lightgrey)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.lightgrey)
                ),
              ),
              controller: prompt,
            )
          ],
        ),
      )),
    );
  }
}