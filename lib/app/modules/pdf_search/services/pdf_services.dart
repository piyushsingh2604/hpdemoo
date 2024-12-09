import 'package:dio/dio.dart';

class PdfServices {
  Dio dio = Dio();

  PdfServices() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://testapi.parliament.health",
        headers: {
          "Authorization":
              "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjJkYmEyZWRhLWRkODAtNDQzNy05MjU5LTgzNzljYmIwMWQzMCIsInN1YiI6ImZxWTh4TVFCZVJmWnhZalVMYXBaMGxaeVZFcUJlM29wVTA5RmtLNFZ3WDg9IiwiZW1haWwiOiJhbmlrZXQueWFkYXZAYW5qaXRhaXQuY29tIiwianRpIjoiY2VkZDYwYzYtZjhkNC00NTFlLWFmOGQtOGY5N2JlMGUxMjJjIiwibmJmIjoxNzMzNTc0ODE2LCJleHAiOjE3NjUxMTA4MTYsImlhdCI6MTczMzU3NDgxNiwiaXNzIjoiaHR0cDovL2FkbWluLnBhcmxpYW1lbnQuaGVhbHRoLyIsImF1ZCI6Imh0dHA6Ly9hZG1pbi5wYXJsaWFtZW50LmhlYWx0aC8ifQ.MAvpqXvnstD7T8tQDKP5BodB8MS_vDVgHOo8MIhG1PhnES5dgNfYebzOfTa-jb8neQ6w8-6RNCNNjW7K0btQ3A",
        },
      ),
    );
  }

  Future createUpdateDiscussion(
    String? title,
    String? body,
    String? id,
    List<String>? images,
    String? source,
  ) async {
    FormData formData = FormData.fromMap({
      "img": images?.map((e) => MultipartFile.fromFileSync(e)).toList(),
      "pdfId": id,
      "discussionId": "",
      "userId": 'HDdgSsaxH3Aogi7LRPEtfQ==',
      "title": title,
      "body": body,
      "tagsList": '',
      "source": source,
      "taggedUsers": '',
      "metadata": '',
    });

    Response response = await dio.post(
      "/CreateUpdateDiscussionV2",
      data: formData,
    );
    if (response.statusCode == 200) {
      print(response.data);
      return true;
    } else {
      return false;
    }
  }
}

