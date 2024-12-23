import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2x2 Rubik\'s Cube',
      theme: ThemeData.dark(),
      home: const CubeScreen(),
    );
  }
}

class CubeState {
  List<List<Color>> faces = [
    [Colors.red, Colors.red, Colors.red, Colors.red], // Front
    [Colors.blue, Colors.blue, Colors.blue, Colors.blue], // Left
    [Colors.green, Colors.green, Colors.green, Colors.green], // Right
    [Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow], // Back
    [Colors.orange, Colors.orange, Colors.orange, Colors.orange], // Top
    [Colors.white, Colors.white, Colors.white, Colors.white], // Bottom
  ];

  void rotateTopClockwise() {
    List<Color> tempTop = [...faces[4]];
    faces[4] = [tempTop[2], tempTop[0], tempTop[3], tempTop[1]];

    List<Color> topRowBack = [faces[3][0], faces[3][1]];
    List<Color> topRowRight = [faces[2][0], faces[2][1]];
    List<Color> topRowFront = [faces[0][0], faces[0][1]];
    List<Color> topRowLeft = [faces[1][0], faces[1][1]];

    faces[0][0] = topRowLeft[0];
    faces[0][1] = topRowLeft[1];
    faces[1][0] = topRowBack[0];
    faces[1][1] = topRowBack[1];
    faces[2][0] = topRowFront[0];
    faces[2][1] = topRowFront[1];
    faces[3][0] = topRowRight[0];
    faces[3][1] = topRowRight[1];
  }

  void rotateTopCounterClockwise() {
    List<Color> tempTop = [...faces[4]];
    faces[4] = [tempTop[1], tempTop[3], tempTop[0], tempTop[2]];

    List<Color> topRowBack = [faces[3][0], faces[3][1]];
    List<Color> topRowRight = [faces[2][0], faces[2][1]];
    List<Color> topRowFront = [faces[0][0], faces[0][1]];
    List<Color> topRowLeft = [faces[1][0], faces[1][1]];

    faces[0][0] = topRowRight[0];
    faces[0][1] = topRowRight[1];
    faces[1][0] = topRowFront[0];
    faces[1][1] = topRowFront[1];
    faces[2][0] = topRowBack[0];
    faces[2][1] = topRowBack[1];
    faces[3][0] = topRowLeft[0];
    faces[3][1] = topRowLeft[1];
  }

  void rotateRightColForward() {
    List<Color> tempRight = [...faces[2]];
    faces[2] = [tempRight[2], tempRight[0], tempRight[3], tempRight[1]];

    List<Color> rightColTop = [faces[4][1], faces[4][3]];
    List<Color> rightColFront = [faces[0][1], faces[0][3]];
    List<Color> rightColBottom = [faces[5][1], faces[5][3]];
    List<Color> rightColBack = [faces[3][2], faces[3][0]];

    faces[4][1] = rightColBack[1];
    faces[4][3] = rightColBack[0];
    faces[0][1] = rightColTop[0];
    faces[0][3] = rightColTop[1];
    faces[5][1] = rightColFront[0];
    faces[5][3] = rightColFront[1];
    faces[3][2] = rightColBottom[1];
    faces[3][0] = rightColBottom[0];
  }

  void rotateRightColBackward() {
    List<Color> tempRight = [...faces[2]];
    faces[2] = [tempRight[1], tempRight[3], tempRight[0], tempRight[2]];

    List<Color> rightColTop = [faces[4][1], faces[4][3]];
    List<Color> rightColFront = [faces[0][1], faces[0][3]];
    List<Color> rightColBottom = [faces[5][1], faces[5][3]];
    List<Color> rightColBack = [faces[3][2], faces[3][0]];

    faces[4][1] = rightColFront[0];
    faces[4][3] = rightColFront[1];
    faces[0][1] = rightColBottom[1];
    faces[0][3] = rightColBottom[0];
    faces[5][1] = rightColBack[1];
    faces[5][3] = rightColBack[0];
    faces[3][2] = rightColTop[0];
    faces[3][0] = rightColTop[1];
  }
}

class CubeScreen extends StatefulWidget {
  const CubeScreen({Key? key}) : super(key: key);

  @override
  _CubeScreenState createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  CubeState cube = CubeState();

  void rotateTopClockwise() {
    setState(() {
      cube.rotateTopClockwise();
    });
  }

  void rotateTopCounterClockwise() {
    setState(() {
      cube.rotateTopCounterClockwise();
    });
  }

  void rotateRightColForward() {
    setState(() {
      cube.rotateRightColForward();
    });
  }

  void rotateRightColBackward() {
    setState(() {
      cube.rotateRightColBackward();
    });
  }

  Widget buildFace(List<Color> faceColors) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Container(color: faceColors[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2x2 Rubik\'s Cube'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Text('Top', style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 100,
                width: 100,
                child: buildFace(cube.faces[4]),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text('Left', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: buildFace(cube.faces[1]),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Front', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: buildFace(cube.faces[0]),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Right', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: buildFace(cube.faces[2]),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text('Rear', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: buildFace(cube.faces[3]),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              const Text('Bottom', style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 100,
                width: 100,
                child: buildFace(cube.faces[5]),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: rotateTopClockwise,
            child: const Text('Rotate Top Clockwise'),
          ),
          ElevatedButton(
            onPressed: rotateTopCounterClockwise,
            child: const Text('Rotate Top Counterclockwise'),
          ),
          ElevatedButton(
            onPressed: rotateRightColForward,
            child: const Text('Rotate Right Column Forward'),
          ),
          ElevatedButton(
            onPressed: rotateRightColBackward,
            child: const Text('Rotate Right Column Backward'),
          ),
        ],
      ),
    );
  }
}
