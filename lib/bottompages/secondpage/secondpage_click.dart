import 'package:flutter/material.dart';
import 'package:expand_widget/expand_widget.dart';

class SecClick extends StatefulWidget {
  const SecClick({super.key});

  @override
  State<SecClick> createState() => _SecClickState();
}

class _SecClickState extends State<SecClick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => OtherPage()));
          },
        ),
        title: const Text('provider로 클릭한 날 전달하기'),
      ),
      body: ListView(
          children: List.generate(
        5,
        (index) {
          return ExpansionTile(
            title: const Text('Tap to expand'),
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.blue,
                child: const Text(
                  'This is a container inside an ExpansionTile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      )
          // body: Theme(
          //   data: ThemeData().copyWith(dividerColor: Colors.transparent),
          //   child: const ExpansionTile(
          //     leading: Text('10:00~11:00'),
          //     title: Text('통영축제'),
          //     trailing: Text('trailing'),
          //     // subtitle: Text('subtitle'),
          //     children: [
          //       Text('통영축제에 대한 설명'),
          //     ],
          //   ),
          // ),
          // body: const ExpandText(
          //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          //   textAlign: TextAlign.justify,
          // ),
          ),
    );
  }
}
