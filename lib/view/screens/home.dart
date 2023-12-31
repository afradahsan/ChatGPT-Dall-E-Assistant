import 'package:chatgpt/model/openai_services.dart';
import 'package:chatgpt/view/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController prompt = TextEditingController();
  SpeechToText speechToText = SpeechToText();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    await speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  //the callback the plugin calls when the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Palette.gptbackground,
      appBar: AppBar(title: const Text('ChatGPT', style: TextStyle(color: Colors.white),), centerTitle: true, backgroundColor: Palette.transparent, elevation: 0,),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: screenHeight/27,),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: Image.asset('assets/images/ChatGPT-Logo.jpg', height: 40, )),
              Text('Hey, How can I help you?', style: TextStyle(color: Colors.white),),
              // Container(
              //   decoration: BoxDecoration(color: Palette.transparent, border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(10)),
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text('Help me Pick\nan outfit that looks good on camera'),
              //   ),
              // ),
              Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        height: screenHeight/15,
                        width: screenWidth/1.27,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter your Prompt Here',
                            hintStyle: TextStyle(color: const Color.fromARGB(115, 255, 255, 255)),
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
                        child: IconButton(icon: Icon(Icons.mic, color: Palette.gptbackground, size: 17,), onPressed: () async{
                          print('listen');
                          if(await speechToText.hasPermission && speechToText.isNotListening){
                            await startListening();
                          }else if(speechToText.isListening){
                            await openAIService.isArtPromptAPI(lastWords);
                            await stopListening();
                          }else{
                            initSpeech();
                          }
                        },)),
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