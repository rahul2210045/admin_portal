import 'dart:convert';
import 'package:admin_portal/models/get_student_data_model.dart';
import 'package:http/http.dart' as http;

class StudentNoSearchRepository {
  final String baseUrl = 'https://cine-admin-xar9.onrender.com/admin/searchStudent';

  Future<List<GetStudentDataModel>> fetchStudents(String name) async {
    final String apiUrl = '$baseUrl?studentNumber=$name';
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
