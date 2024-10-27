import 'dart:convert';

MythologyModel generalKModalFromJson(String str) => MythologyModel.fromJson(json.decode(str));
String generalKModalToJson(MythologyModel data) => json.encode(data.toJson());

class MythologyModel {
  MythologyModel({
    num? responseCode,
    List<Results>? results,}){
    _responseCode = responseCode;
    _results = results;
  }

  MythologyModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  num? _responseCode;
  List<Results>? _results;
  MythologyModel copyWith({  num? responseCode,
    List<Results>? results,
  }) => MythologyModel(  responseCode: responseCode ?? _responseCode,
    results: results ?? _results,
  );
  num? get responseCode => _responseCode;
  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Results resultsFromJson(String str) => Results.fromJson(json.decode(str));
String resultsToJson(Results data) => json.encode(data.toJson());
class Results {
  Results({
    String? type,
    String? difficulty,
    String? category,
    String? question,
    String? correctAnswer,
    List<String>? incorrectAnswers,}){
    _type = type;
    _difficulty = difficulty;
    _category = category;
    _question = question;
    _correctAnswer = correctAnswer;
    _incorrectAnswers = incorrectAnswers;
  }

  Results.fromJson(dynamic json) {
    _type = json['type'];
    _difficulty = json['difficulty'];
    _category = json['category'];
    _question = json['question'];
    _correctAnswer = json['correct_answer'];
    _incorrectAnswers = json['incorrect_answers'] != null ? json['incorrect_answers'].cast<String>() : [];
  }
  String? _type;
  String? _difficulty;
  String? _category;
  String? _question;
  String? _correctAnswer;
  List<String>? _incorrectAnswers;
  Results copyWith({  String? type,
    String? difficulty,
    String? category,
    String? question,
    String? correctAnswer,
    List<String>? incorrectAnswers,
  }) => Results(  type: type ?? _type,
    difficulty: difficulty ?? _difficulty,
    category: category ?? _category,
    question: question ?? _question,
    correctAnswer: correctAnswer ?? _correctAnswer,
    incorrectAnswers: incorrectAnswers ?? _incorrectAnswers,
  );
  String? get type => _type;
  String? get difficulty => _difficulty;
  String? get category => _category;
  String? get question => _question;
  String? get correctAnswer => _correctAnswer;
  List<String>? get incorrectAnswers => _incorrectAnswers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['difficulty'] = _difficulty;
    map['category'] = _category;
    map['question'] = _question;
    map['correct_answer'] = _correctAnswer;
    map['incorrect_answers'] = _incorrectAnswers;
    return map;
  }

}