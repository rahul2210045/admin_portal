import 'dart:convert';
import 'package:admin_portal/repository/models/feedback_details_model.dart';
import 'package:http/http.dart' as http;


class FeedbackDetailsRepository {
  final String baseUrl;

  FeedbackDetailsRepository({required this.baseUrl});

  Future<List<FeedbackDetails>> getFeedbacks() async {
    final response = await http.get(Uri.parse('$baseUrl/feedbacks'));

    if (response.statusCode == 200) {
      try {
        List<dynamic> body = json.decode(response.body);
        List<FeedbackDetails> feedbacks = body.map((dynamic item) => FeedbackDetails.fromJson(item)).toList();
       
        return feedbacks;
      } catch (e) {
        throw Exception('Failed to parse feedbacks: $e');
      }
    } else {
      throw Exception('Failed to load feedbacks: ${response.reasonPhrase}');
    }
  }
}
