import 'package:enter_training_me/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentExerciseDetail extends StatefulWidget {
  const CurrentExerciseDetail({Key? key}) : super(key: key);

  @override
  State<CurrentExerciseDetail> createState() => _CurrentExerciseDetailState();
}

class _CurrentExerciseDetailState extends State<CurrentExerciseDetail> {
  bool _isShowingDescription = false;

  static const description = """
          Morbi mollis tellus ac sapien. Donec mollis hendrerit risus. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Cras ultricies mi eu turpis hendrerit fringilla. Nulla sit amet est.

Phasellus gravida semper nisi. Vestibulum rutrum, mi nec elementum vehicula, eros quam gravida nisl, id fringilla neque ante vel mi. Donec id justo. Aenean viverra rhoncus pede. Nulla consequat massa quis enim.

Cras varius. Proin sapien ipsum, porta a, auctor quis, euismod ut, mi. Sed augue ipsum, egestas nec, vestibulum et, malesuada adipiscing, dui. Nulla consequat massa quis enim. Fusce fermentum odio nec arcu.

Maecenas nec odio et ante tincidunt tempus. Suspendisse feugiat. Suspendisse feugiat. Pellentesque ut neque. Praesent ac massa at ligula laoreet iaculis.

Suspendisse faucibus, nunc et pellentesque egestas, lacus ante convallis tellus, vitae iaculis lacus elit id tortor. Curabitur blandit mollis lacus. Suspendisse nisl elit, rhoncus eget, elementum ac, condimentum eget, diam. Fusce convallis metus id felis luctus adipiscing. Nam adipiscing.
          """;

  Widget _renderExerciseImage(){
    return Image.asset("assets/exercises/pull_up.png");
  }

  Widget _renderExerciseDescription(){
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(description)
        ],
      ),
    );
  }
  
  Widget _renderExerciseInfo(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: Text("Pull Up", style: Theme.of(context).textTheme.headline2,)),
            Text("1/3 sets", style: TextStyle(fontSize: 16),),
            // Text("1/3 sets", style: Theme.of(context).textTheme.headline4),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("10", style: Theme.of(context).textTheme.headline1),
            Text("@50kgs", style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        color: CustomTheme.middleGreen
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.arrow_circle_down_sharp),
                  onPressed: (){

                },),
                IconButton(icon: const Icon(Icons.arrow_circle_up_sharp),
                  onPressed: (){
                },),
              ],
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  setState(() {
                    _isShowingDescription = !_isShowingDescription;
                  });
                },
                child: _isShowingDescription ? _renderExerciseDescription() : _renderExerciseImage(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _renderExerciseInfo(),
            ),
          ],
        ),
      ),
    );
  }
}
