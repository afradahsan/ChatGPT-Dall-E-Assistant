import 'dart:convert';

import 'package:chatgpt/view/constants/.gitignore';
import 'package:http/http.dart' as http;

class OpenAIService{
  Future<String> isArtPromptAPI(String prompt) async{
    try{
      final response = await http.post(Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openAIKey' 
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': {
          'role': 'user',
          'content': 'Does this message want to generate an AI picture, image or Art: $prompt, Reply with a Yes or a No'
        }
      }),
      );
      print(response.body);
      if(response.statusCode == 200){
        print('success');
      }
    }catch(e){
      return e.toString();
    }
    return 'AI';
  }
}