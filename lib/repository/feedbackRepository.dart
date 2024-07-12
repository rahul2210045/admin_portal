// import 'dart:convert';
// import 'package:admin_portal/main.dart';
// import 'package:admin_portal/repository/models/feedbackModel.dart';
// import 'package:http/http.dart' as http;

// class FeedbackRepository {
//   final String baseUrl;

//   FeedbackRepository({required this.baseUrl});

//   Future<List<feedbackModel>> fetchFeedbackQuestions() async {
//     final url = Uri.parse('${baseUrl}/admin/feedback/getFeedbackQuestions');
    
//     // Retrieve the access token
//     final String accessToken = PreferencesManager().token;

//     // Set up the headers including the access token
//     final headers = {
//       'Content-Type': 'application/json',
//       'Cookie': 'accessToken=$accessToken',
//     };

//     final response = await http.get(url, headers: headers);

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       return jsonList.map((json) => feedbackModel.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load feedback questions: ${response.statusCode} ${response.body}');
//     }
//   }
// }
import 'dart:convert';
import 'package:admin_portal/main.dart';
import 'package:admin_portal/repository/Feedback_addQues_Repository.dart';
import 'package:http/http.dart' as http;
import 'package:admin_portal/repository/models/feedbackModel.dart';
import 'package:admin_portal/repository/models/feedbackUpdateModel.dart'; // Assuming you've created this model

class FeedbackRepository {
  final String baseUrl;

  FeedbackRepository({required this.baseUrl});

  Future<List<feedbackModel>> fetchFeedbackQuestions() async {
    final url = Uri.parse('$baseUrl/admin/feedback/getFeedbackQuestions');
    
    // Example of retrieving access token - replace with your actual implementation
    final String accessToken = PreferencesManager().token;

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

  Future<void> updateFeedbackQuestion(FeedbackUpdate feedbackUpdate) async {
    final url = Uri.parse('$baseUrl/admin/feedback/updateFeedbackQuestion');
    
    // Example of retrieving access token - replace with your actual implementation
    final String accessToken = PreferencesManager().token;

    final headers = {
      'Content-Type': 'application/json',
      'Cookie': 'accessToken=$accessToken',
    };

    final response = await http.patch(
      url,
      headers: headers,
      body: jsonEncode(feedbackUpdate.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update feedback question: ${response.statusCode} ${response.body}');
    }
  }

  Future<AddFeedback> addFeedbackQuestion(String question, String quesId) async {
    final url = Uri.parse('$baseUrl/admin/feedback/addFeedbackQuestion');
    
    // Example of retrieving access token - replace with your actual implementation
    final String accessToken = PreferencesManager().token;

    final headers = {
      'Content-Type': 'application/json',
      'Cookie': 'accessToken=$accessToken',
    };

    final body = jsonEncode({
      'quesId': quesId,
      'question': question,
    });

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return AddFeedback.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add feedback question: ${response.statusCode} ${response.body}');
    }
  }
}
