import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flashcard_quiz_app/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'LearningScreen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

final List<String> Categories = [
  'General Knowledge',
  'Science & Nature',
  'Sports',
  'History',
  'Mythology',
  'Mathematics',
  'Random'
];

final List<String> ImageList = [
  'https://th.bing.com/th/id/OIP.4Q1cFwCANiQ5E439vLc0QAHaGi?rs=1&pid=ImgDetMain',
  'https://th.bing.com/th/id/OIP.Be3AwOU-tlQoOzKQnfHYJgHaE8?rs=1&pid=ImgDetMain',
  'https://th.bing.com/th/id/OIP.dQJXy0gXF6E6j6dJON3F9gHaEi?rs=1&pid=ImgDetMain',
  'https://th.bing.com/th/id/R.4f6d632e96cf5ba9a008d0b9968c869b?rik=%2f4mlP7Kg5MKfPg&pid=ImgRaw&r=0',
  'https://th.bing.com/th/id/OIP.ZZmnd58o-yvzkGReXNODsQHaE6?rs=1&pid=ImgDetMain',
  'https://th.bing.com/th/id/OIP.CX6DcaAATI9Hi8S91HFnPQHaHa?w=900&h=900&rs=1&pid=ImgDetMain',
  'https://th.bing.com/th/id/R.dd3cdcda1a4ef4382aa6faf90f101884?rik=8V0YdfOjmc2z9w&riu=http%3a%2f%2fclipground.com%2fimages%2fcute-question-marks-clipart-8.jpg&ehk=s9508IJ6Dv5obj4yztqx6Jyv6e8%2fdHIyjOlrbhrK0p8%3d&risl=&pid=ImgRaw&r=0',
];

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 15.0,
                ),
                itemCount: Categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Learningscreen(
                            category: Categories[index],
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: ImageList[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                           Opacity(
                              opacity: 0.6,
                              child: Container(
                                color: Colors.black87,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: CachedNetworkImageProvider(ImageList[index]),
                                    radius: 20,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Text(
                                  Categories[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: Icon(Icons.play_arrow, color: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QuizScreen(category: Categories[index],),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
