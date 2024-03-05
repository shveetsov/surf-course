import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Задание — GestureMaster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _posX = 0;
  double _posY = 0;
  final double _widthContainer = 100;
  final double _heightContainer = 100;
  double _rotation = 0;
  bool selected = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _posX = MediaQuery.of(context).size.width/2 - _widthContainer/2;
    _posY = MediaQuery.of(context).size.height/2 - _heightContainer/2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Задание — GestureMaster'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: _posX,
            top: _posY,
            child: AnimatedRotation(
              turns: _rotation,
              duration: const Duration(milliseconds: 500),
              child: AnimatedContainer(
                width: _widthContainer,
                height: _heightContainer,
                color: selected ? Colors.blue : Colors.deepOrange,
                duration: const Duration(milliseconds: 500),
              ),
            ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selected = !selected;
                });
              },
              onLongPress: (){
                setState(() {
                  _rotation += 0.1;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _posX += details.delta.dx;
                  _posY += details.delta.dy;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
