import 'package:flutter/material.dart';
import 'package:latte/size_config.dart';

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
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Container(
          width: getProportionateScreenWidth(160),
          height: getProportionateScreenHeight(160),
          color: Colors.black,
        ),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
      ],
    );
  }
}
