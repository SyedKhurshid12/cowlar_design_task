import 'package:cowlar_design_task/api_provider/api_provider.dart';
import 'package:cowlar_design_task/config/const_url.dart';
import 'package:dio/dio.dart';

// Import WidgetsFlutterBinding to ensure proper initialization
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() async{
  await dotenv.load(fileName: '.env');

  group('ApiProvider', () {
    // Ensure proper initialization of WidgetsBinding before running tests
    WidgetsFlutterBinding.ensureInitialized();

    test('get list of upcoming movie list', () async {
      MockDio dio = MockDio();
      ApiProvider apiProvider = ApiProvider(dioApi: dio);

      // Stub the response of dio.get with headers
      when(() => dio.get(upcomingMovieApi)).thenAnswer(
        (_) async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(
            path: upcomingMovieApi,
            queryParameters: {'api_key': '5e0fbb7ee2fae495cf56bc8b78f3cb44'},
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTUyODIwNjMsImRhdGEiOnsidXNlcklkIjoiOTIzNDU4MDI2NzQxIiwidXNlciI6eyJpZCI6IjlkMGJlZWZhLTIyZTUtYWUwNi1hNWU1LTMwYTdlMmY0MDU0MSIsInVzZXJuYW1lIjoiOTIzNDU4MDI2NzQxIiwicGFzc3dvcmQiOiIkMmIkMTAkUTBkRjV0TGVVMnQzaS5USHV2RWFzdVdvSnZ6SGJCdlRFa2UxU09WMDdYbUJBU2FnRGJYbDIiLCJzY29wZSI6bnVsbCwib3BlcmF0b3JJZCI6bnVsbCwidXNlclR5cGUiOiJTdWJzY3JpYmVyIiwiZmlyZWJhc2VVaWQiOm51bGwsImlzMmZhRW5hYmxlZCI6ZmFsc2UsInVzZXJUeXBlSWQiOiI3IiwiaW5mbyI6eyJpZCI6IjlkMGJlZWZhLTIyZTUtYWUwNi1hNWU1LTMwYTdlMmY0MDU0MSIsInVzZXJuYW1lIjoiOTIzNDU4MDI2NzQxIiwicGFzc3dvcmQiOiIkMmIkMTAkUTBkRjV0TGVVMnQzaS5USHV2RWFzdVdvSnZ6SGJCdlRFa2UxU09WMDdYbUJBU2FnRGJYbDIiLCJzY29wZSI6bnVsbCwib3BlcmF0b3JJZCI6bnVsbCwidXNlclR5cGUiOiJTdWJzY3JpYmVyIiwiZmlyZWJhc2VVaWQiOm51bGwsImlzMmZhRW5hYmxlZCI6ZmFsc2UsInVzZXJUeXBlSWQiOiI3Iiwicm9sZXMiOlt7ImlkIjoiNyIsInRpdGxlIjoiU3Vic2NyaWJlciIsImFwcCI6dHJ1ZSwicG9ydGFsIjpmYWxzZSwiZ3VpZCI6ImM4MWM1MjZlLTBiYzUtNmM1NS00NmE5LTM3MmE4MmUxNmQxNyIsInN1YnNjcmliZXJSb2xlSWQiOiIzZTkyNmIyZS0wMmVlLTMyZTAtNzI4My01ZDA5M2Y3MjkxZTkiLCJyb2xlUmVzb3VyY2VzIjpbXX1dfX19LCJpYXQiOjE3MTUyMzg4NjN9.CbZyJoYYdDt72x9FqL6Wo0rqbdmUuJ76DHSGTHfPg3o'
            },
          ),
        ),
      );

      final response = await apiProvider.fetchUpcomingMovie();

      // Verify that the response data matches the expected data
      // Verify that the response data matches the expected data
      // For example, you can check the length of the results list
      expect(response.results?.length, 20);

      // Add more specific assertions based on your expected data
      // For example, you can check the title of the first movie
      expect(response.results?[0]?.title, 'Kingdom of the Planet of the Apes');
    });

    // Add more test cases for other scenarios such as failure, null response, and network error
  });
}
