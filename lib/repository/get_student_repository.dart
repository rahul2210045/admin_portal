import 'dart:convert';
import 'package:admin_portal/models/get_student_data_model.dart';
import 'package:http/http.dart' as http;

class StudentRepository {
  final String apiUrl = 'https://cine-admin-xar9.onrender.com/admin/students';

  Future<List<GetStudentDataModel>> fetchStudents() async {
    var response = await http.get(Uri.parse(apiUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<GetStudentDataModel> students = body
          .map((dynamic item) => GetStudentDataModel.fromJson(item))
          .toList();
      return students;
    } else {
      throw Exception('Failed to load students');
    }
  }
}
