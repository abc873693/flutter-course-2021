import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:http_crawler/models/news.dart';

class Helper {
  static Future<List<News>> getNews() async {
    final dio = Dio();
    final response = await dio.post(
      "https://acad.nkust.edu.tw/app/index.php?Action=mobilercglist",
      data: FormData.fromMap(
        {
          "Rcg": "232",
          "Op": "getpartlist",
          "Page": "1",
        },
      ),
    );
    List<News> data = [];
    // print(response.data.runtimeType);
    // print(response.data);
    final json = jsonDecode(response.data);
    // print(json.runtimeType);
    final rawHtml = json['content'];
    // print(rawHtml);
    final doc = parse(rawHtml);
    final trs = doc.getElementsByTagName("tr");
    for (var tr in trs) {
      final tds = tr.getElementsByTagName('td');
      if (tds.length < 3) continue;
      data.add(
        News(
          tds[0].text.trim(),
          tds[1].text.trim(),
          tds[2].text.trim(),
          tds[2].getElementsByTagName('a').first.attributes['href'],
        ),
      );
    }
    return data;
  }
}
