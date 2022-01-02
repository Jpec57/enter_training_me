import 'package:enter_training_me/pages/exercise_list/exercise_hero.dart';
import 'package:enter_training_me/pages/exercise_view/exercise_view_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExerciseListPage extends StatefulWidget {
  static const routeName = "/exercises";

  const ExerciseListPage({Key? key}) : super(key: key);

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Chercher un exercice",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
                controller: _searchController,
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return ExerciseHero(
                      index: index,
                      onTap: () {
                        context.go(ExerciseViewPage.routeName
                            .replaceFirst(':id', 1.toString()));
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
