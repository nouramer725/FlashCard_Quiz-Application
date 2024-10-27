import 'package:easy_localization/easy_localization.dart';
import 'package:flashcard_quiz_app/cubit/categories_cubit/cubit.dart';
import 'package:flashcard_quiz_app/widgets/category_item.dart';
import 'package:flashcard_quiz_app/widgets/custom_appbar.dart';
import 'package:flashcard_quiz_app/widgets/categories_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/categories_cubit/states.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  static List<Color?> colors = [
    Colors.green[300],
    Colors.yellow[300],
    Colors.blue[300],
    const Color(0xffe1afd1),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          key: CategoriesCubit.get(context).scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Column(
                  children: [
                    const CustomAppBar(),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40,),
                        const Icon(
                          Icons.category_outlined,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Your Categories'.tr(),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                CategoriesCubit.get(context).categories.isEmpty
                    ?  Center(
                        child: Text(
                          'No Categories Yet'.tr(),
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ) : Expanded(
                        child: CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverGrid.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.4,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return CategoryItem(
                                  color: index % 4 == 0
                                      ? colors[0]!
                                      : index % 4 == 1
                                          ? colors[1]!
                                          : index % 4 == 2
                                              ? colors[2]!
                                              : colors[3]!,
                                  index: index,
                                );
                              },
                              itemCount: CategoriesCubit.get(context).categories.length,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          floatingActionButton: CategoriesFloatingActionButton(),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
