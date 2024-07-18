import 'package:flutter/material.dart';

class DiaryBlock extends StatefulWidget {
  const DiaryBlock({super.key});

  @override
  State<DiaryBlock> createState() => _DiaryBlockState();
}

class _DiaryBlockState extends State<DiaryBlock> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 160,
          height: 160,
          color: Colors.black,
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
