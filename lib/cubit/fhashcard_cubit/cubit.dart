import 'package:flashcard_quiz_app/cubit/fhashcard_cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class FlashCardsCubit extends Cubit<FlashCardsState> {
  FlashCardsCubit() : super(InitialFlashCardsState());

  static FlashCardsCubit get(context) => BlocProvider.of(context);
  late Database database;
  List<Map> flashcards = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> createDatabase() async {
    database = await openDatabase(
      'flashcardss.db',
      version: 4,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE flashcardss (id INTEGER PRIMARY KEY, question TEXT, true_answer TEXT, false_answer TEXT, false_answer2 TEXT, false_answer3 TEXT, category TEXT)',
        ).then((value) {
          print('Table created');
        }).catchError((e) {
          print('Error creating table: $e');
          throw e;
        });
      },
      onOpen: (db) async {
        print('Database opened');
        await getDataFromDatabase(db).then((value) {
          flashcards = value;
          emit(GetFlashCardsState());
        });
      },
    );
  }

  Future<void> insertIntoDatabase({
    required String question,
    required String trueAnswer,
    required String falseAnswer,
    required String false2Answer,
    required String false3Answer,
    required String category,
  }) async {
    try {
      await database.transaction((txn) async {
        await txn.rawInsert(
          'INSERT INTO flashcardss(question, true_answer, false_answer, false_answer2, false_answer3, category) VALUES(?, ?, ?, ?, ?, ?)',
          [question, trueAnswer, falseAnswer, false2Answer, false3Answer, category],
        ).then((value) {
          print('Inserted successfully: $value');
          emit(AddFlashCardState());
        }).catchError((e) {
          print('Error inserting into database: $e');
          throw e;
        });
      });
    } catch (e) {
      print('Transaction error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getDataFromDatabase(Database db) async {
    try {
      final results = await db.rawQuery('SELECT * FROM flashcardss');
      emit(GetFlashCardsState()); // Make sure this is valid for your state management
      print(results);
      return results;
    } catch (e) {
      print('Error querying database: $e');
      throw e;
    }
  }

  bool isBottomSheetOpened = false;
  TextEditingController questionController = TextEditingController();
  TextEditingController trueAnswerController = TextEditingController();
  TextEditingController falseAnswerController = TextEditingController();
  TextEditingController falseAnswer2Controller = TextEditingController();
  TextEditingController falseAnswer3Controller = TextEditingController();

  void closeButtonSheet() {
    isBottomSheetOpened = false;
    questionController.clear();
    trueAnswerController.clear();
    falseAnswerController.clear();
    falseAnswer2Controller.clear();
    falseAnswer3Controller.clear();

    emit(CloseFlashCardBottomSheetState());
  }

  void closeButtonSheetManual() {
    isBottomSheetOpened = false;
    emit(CloseFlashCardBottomSheetManualState());
  }

  void openButtonSheet() {
    isBottomSheetOpened = true;
    emit(OpenFlashCardBottomSheetState());
  }
}
