import 'package:flutter/material.dart';

class PlayScreenBoard extends StatelessWidget {
  const PlayScreenBoard({
    super.key,
    required this.snakePosition,
    required this.direction,
    required this.foodPosition,
    required this.bonusPosition,
    required this.bonusTime,
    required this.obstacles,
  });

  final List<int> snakePosition;
  final String direction;
  final int foodPosition;
  final int bonusPosition;
  final double bonusTime;
  final List<int> obstacles;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 650,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 25,
      ),
      itemBuilder: (context, index) {
        if (snakePosition.last == index) {
          return Container(
            margin: EdgeInsets.all(.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: (direction == "up" || direction == "down")
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 4.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: Color(0xff424242),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 4.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: Color(0xff424242),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 4.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: Color(0xff424242),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 4.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: Color(0xff424242),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
          );
        } else if (snakePosition.contains(index)) {
          return Container(
            margin: EdgeInsets.all(.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        } else if (index == foodPosition) {
          return Container(
            margin: EdgeInsets.all(.5),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          );
        } else if (index == bonusPosition && bonusTime > 0) {
          return Container(
            margin: EdgeInsets.all(.5),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          );
        } else if (obstacles.contains(index)) {
          return Container(
            margin: EdgeInsets.all(.5),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.all(.5),
            color: Colors.grey[900],
          );
        }
      },
    );
  }
}
