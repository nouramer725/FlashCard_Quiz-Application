import 'package:flashcard_quiz_app/cubit/fhashcard_cubit/cubit.dart';
import 'package:flashcard_quiz_app/views/result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart'; // Import for localization
import '../cubit/fhashcard_cubit/state.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key, required this.len, required this.flashcards});
  final List<Map> flashcards;
  final int len;

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  int index = 0;
  int counter = 0;

  void checkAnswer(String selectedAnswer) {
    // Compare selected answer with the correct answer
    if (selectedAnswer == widget.flashcards[index]['true_answer']) {
      counter++;
    }

    // Move to the next question or navigate to the result page
    if (index == widget.flashcards.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultView(
            result: counter,
            total: widget.flashcards.length,
          ),
        ),
      );
    } else {
      setState(() {
        index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlashCardsCubit, FlashCardsState>(
      builder: (BuildContext context, state) {
        final flashcard = widget.flashcards[index];
        final question = flashcard['question'] as String? ?? 'No Question'.tr();
        final trueAnswer = flashcard['true_answer'] as String? ?? 'No Answer'.tr();
        final falseAnswer = flashcard['false_answer'] as String? ?? 'No Answer'.tr();
        final falseAnswer2 = flashcard['false_answer2'] as String? ?? 'No Answer'.tr();
        final falseAnswer3 = flashcard['false_answer3'] as String? ?? 'No Answer'.tr();

        return Scaffold(
          appBar: AppBar(
            title: Text('${flashcard['id']} / ${widget.len}'),
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.78,
                    height: MediaQuery.sizeOf(context).height * 0.55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.purple[300]!,
                        width: 5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            question,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Answer option 1 (True Answer)
                          answerOption(context, trueAnswer),
                          const SizedBox(height: 20),
                          // Answer option 2 (False Answer)
                          answerOption(context, falseAnswer),
                          const SizedBox(height: 20),
                          // Answer option 3 (False Answer 2)
                          answerOption(context, falseAnswer2),
                          const SizedBox(height: 20),
                          // Answer option 4 (False Answer 3)
                          answerOption(context, falseAnswer3),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }

  // Reusable widget for answer option
  Widget answerOption(BuildContext context, String answerText) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.purple[300]!,
          width: 5,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          checkAnswer(answerText);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            answerText.tr(), // Apply localization to answer options
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
