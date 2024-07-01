import 'dart:convert';
import 'package:admin_portal/main.dart';
import 'package:admin_portal/repository/models/feedbackModel.dart';
import 'package:http/http.dart' as http;

class FeedbackRepository {
  final String baseUrl;

  FeedbackRepository({required this.baseUrl});

  Future<List<feedbackModel>> fetchFeedbackQuestions() async {
    final url = Uri.parse('$baseUrl/admin/feedback/feedbackQuestions');
    
    // Retrieve the access token
    final String accessToken = PreferencesManager().token;

    // Set up the headers including the access token
    final headers = {
      'Content-Type': 'application/json',
      'Cookie': 'accessToken=$accessToken',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => feedbackModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load feedback questions: ${response.statusCode} ${response.body}');
    }
  }
}
