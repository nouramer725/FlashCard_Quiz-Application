import 'dart:convert';
import 'package:flashcard_quiz_app/Api/modal/MythologhyModel.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'Api/modal/GeneralKModal.dart';
import 'Api/modal/HistoryModal.dart';
import 'Api/modal/RandomModal.dart';
import 'Api/modal/ScienceModal.dart';
import 'Api/modal/SportsModal.dart';

class Learningscreen extends StatefulWidget {
  final String category;

  const Learningscreen({super.key, required this.category});

  @override
  State<Learningscreen> createState() => _LearningscreenState();
}

class _LearningscreenState extends State<Learningscreen> {
  late Future<dynamic> _futureData;

  final Map<String, Map<String, String>> _categoryInfo = {
    'General Knowledge': {
      'url': 'https://opentdb.com/api.php?amount=50&category=9&difficulty=medium&type=multiple',
      'modal': 'GeneralKModal',
    },
    'Science & Nature': {
      'url': 'https://opentdb.com/api.php?amount=50&category=17&difficulty=medium&type=multiple',
      'modal': 'ScienceModal',
    },
    'Sports': {
      'url': 'https://opentdb.com/api.php?amount=50&category=21&difficulty=medium&type=multiple',
      'modal': 'SportsModal',
    },
    'History': {
      'url': 'https://opentdb.com/api.php?amount=50&category=23&difficulty=medium&type=multiple',
      'modal': 'HistoryModal',
    },
    'Mythology': {
      'url': 'https://opentdb.com/api.php?amount=25&category=20&difficulty=medium',
      'modal': 'HistoryModal',
    },
    'Mathematics': {
      'url': 'https://opentdb.com/api.php?amount=20&category=19&difficulty=medium&encode=url3986',
      'modal': 'HistoryModal',
    },
    'Random': {
      'url': 'https://opentdb.com/api.php?amount=50&difficulty=medium&type=multiple',
      'modal': 'RandomModal',
    },

  };

  @override
  void initState() {
    super.initState();
    _futureData = getUserData();
  }

  String decodeHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body!.text;
  }

  Future<dynamic> getUserData() async {
    final categoryInfo = _categoryInfo[widget.category] ?? _categoryInfo[_translateCategory(widget.category)];

    if (categoryInfo == null) {
      throw Exception('Invalid category');
    }

    final apiUrl = categoryInfo['url'];
    final modalClass = categoryInfo['modal'];

    int retryCount = 0;
    const maxRetries = 3;
    const retryDelay = Duration(seconds: 2);

    while (retryCount < maxRetries) {
      try {
        final response = await http.get(Uri.parse(apiUrl!));
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          return _parseData(jsonData, modalClass!);
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        retryCount++;
        if (retryCount >= maxRetries) {
          throw Exception('Error fetching data after $maxRetries retries: $e');
        }
        await Future.delayed(retryDelay);
      }
    }
  }

  dynamic _parseData(Map<String, dynamic> jsonData, String modalClass) {
    switch (modalClass) {
      case 'GeneralKModal':
        return GeneralKModal.fromJson(jsonData);
      case 'ScienceModal':
        return ScienceModal.fromJson(jsonData);
      case 'SportsModal':
        return SportsModal.fromJson(jsonData);
      case 'HistoryModal':
        return HistoryModal.fromJson(jsonData);
      case 'Mythology':
        return MythologyModel.fromJson(jsonData);
      case 'Mathematics':
        return HistoryModal.fromJson(jsonData);
      case 'RandomModal':
        return RandomModal.fromJson(jsonData);
      default:
        throw Exception('Unknown modal class');
    }
  }

  String _translateCategory(String category) {
    final Map<String, String> arabicToEnglish = {
      'المعرفة العامة': 'General Knowledge',
      'العلوم والطبيعة': 'Science & Nature',
      'الرياضة': 'Sports',
      'التاريخ': 'History',
      'عشوائي': 'Random',
    };

    return arabicToEnglish[category] ?? category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category,
            style: TextStyle(fontSize: 25)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
          )
        ],
      ),
      body: FutureBuilder<dynamic>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.purple));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as dynamic).results == null) {
            return Center(child: Text('No data available'));
          } else {
            final results = (snapshot.data as dynamic).results!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL, // Specify the direction of the flip
                    front: Card(
                      color: Colors.purple[200],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${index + 1}:  ' +
                                    decodeHtml(result.question.toString()),
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                    back: Card(
                      color: Colors.purple,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(decodeHtml(result.correctAnswer.toString()),
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
