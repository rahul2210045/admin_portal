import 'dart:convert';
import 'package:admin_portal/repository/models/feedbackModel.dart';
import 'package:http/http.dart' as http;


class FeedbackRepository {
  final String baseUrl;

  FeedbackRepository({required this.baseUrl});

  Future<List<feedbackModel>> fetchFeedbackQuestions() async {
    final url = Uri.parse('$baseUrl/admin/feedback/feedbackQuestions');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => feedbackModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load feedback questions' + response.statusCode.toString());

    }
  }
}
