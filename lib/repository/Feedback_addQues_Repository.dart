import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin_portal/main.dart';  

class AddFeedback {
  String? message;

  AddFeedback({this.message});

  AddFeedback.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

class addFeedbackRepository {
  final String baseUrl;

  addFeedbackRepository({required this.baseUrl});

  Future<AddFeedback> addFeedbackQuestion(String question, ) async {
    final url = Uri.parse('$baseUrl/admin/feedback/addFeedbackQuestion');
    
    // Retrieve the access token
    final String accessToken = PreferencesManager().token;

    // Set up the headers including the access token
    final headers = {
      'Content-Type': 'application/json',
      'Cookie': 'accessToken=$accessToken',
    };

    final Map<String, dynamic> requestBody = {
      'question': question,
      // 'quesId': quesId,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      print(response.body+"  added");
      return AddFeedback.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to add feedback question: ${response.statusCode} ${response.body}');
    }
  }
}

