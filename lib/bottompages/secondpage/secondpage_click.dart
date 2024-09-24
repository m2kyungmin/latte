import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latte/bottompages/secondpage/secondpage.dart';

class SecClick extends StatefulWidget {
  const SecClick({super.key});

  @override
  State<SecClick> createState() => _SecClickState();
}

class _SecClickState extends State<SecClick> {
  late String _year;
  late String _month;
  late String _day;

  @override
  void initState() {
    var splitDay = SecondPage.selectedDay.toString().split('');
    _year = splitDay.sublist(0, 3).join('');
    _month = splitDay.sublist(5, 7).join('');
    _day = splitDay.sublist(8, 10).join('');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromARGB(255, 252, 246, 248),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 252, 246, 248),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('$_month월 $_day일'),
        ),
        body: FutureBuilder(
          future: _fromFirestore(),
          builder: (context, snapshot) => ListView(
              children: List.generate(
            snapshot.data?.length ?? 1,
            (index) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Center(child: CircularProgressIndicator());
              // } else if (snapshot.connectionState == ConnectionState.done) {
              //   if (snapshot.hasError) {
              //     return Center(child: Text('Error: ${snapshot.error}'));
              //   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              //     return const Center(child: Text('No data available'));
              //   } else {
              //     final users = snapshot.data!;
              //     return ListView.builder(
              //       itemCount: users.length,
              //       itemBuilder: (context, index) {
              //         final user = users[index];
              //         return ListTile(
              //           title: Text('${snapshot.data?['id']}'),
              //           subtitle: Text(user['rank']),
              //         );
              //       },
              //     );
              //   }
              // } else {
              //   return Center(child: Text('State: ${snapshot.connectionState}'));
              // }
              CameraPosition position = CameraPosition(
                  target: LatLng(
                      double.parse(snapshot.data?[index].coordinate_3d ?? '0'),
                      double.parse(snapshot.data?[index].coordinate_4d ?? '0')),
                  zoom: 15);
              return Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                          '${snapshot.data?[index].s_time} ~ ${snapshot.data?[index].e_time}'),
                      trailing: Text(
                        snapshot.data?[index].title ?? "111",
                        style: const TextStyle(fontSize: 14),
                      ),
                      children: <Widget>[
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Column(
                                  children: [
                                    Text('기간'),
                                    SizedBox(height: 10),
                                    Text('시간'),
                                    SizedBox(height: 10),
                                    Text('장소'),
                                    SizedBox(height: 10),
                                    Text('요금'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                        '${snapshot.data?[index].s_date} ~ ${snapshot.data?[index].e_date}'),
                                    const SizedBox(height: 10),
                                    Text(
                                        '${snapshot.data?[index].s_time} ~ ${snapshot.data?[index].e_time}'),
                                    const SizedBox(height: 10),
                                    Text('${snapshot.data?[index].location}'),
                                    const SizedBox(height: 10),
                                    Text('${snapshot.data?[index].fee}'),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      '${snapshot.data?[index].image}',
                                      // width: 100,
                                      // height: 100,
                                      scale: 3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: GoogleMap(
                                initialCameraPosition: position,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )),
        ),
      ),
    );
  }
}

class Test {
  final String? id;
  final String? rank;
  final String? name;
  final String? e_time;
  final String? s_time;
  final String? fee;
  final String? title;
  final String? location;
  final String? e_date;
  final String? s_date;
  final String? image;
  final String? coordinate_3d;
  final String? coordinate_4d;

  Test({
    required this.id,
    required this.rank,
    required this.name,
    required this.e_time,
    required this.s_time,
    required this.e_date,
    required this.s_date,
    required this.fee,
    required this.title,
    required this.location,
    required this.image,
    required this.coordinate_3d,
    required this.coordinate_4d,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json["id"],
      rank: json["rank"],
      name: json["name"],
      e_time: json["e_time"],
      s_time: json["s_time"],
      e_date: json["e_date"],
      s_date: json["s_date"],
      fee: json["fee"],
      title: json["title"],
      location: json["location"],
      image: json["image"],
      coordinate_3d: json["coordinate_3d"],
      coordinate_4d: json["coordinate_4d"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "rank": rank,
      "name": name,
      "e_time": e_time,
      "s_time": s_time,
      "e_date": e_date,
      "s_date": s_date,
      "fee": fee,
      "title": title,
      "location": location,
      "image": image,
      "coordinate_3d": coordinate_3d,
      "coordinate_4d": coordinate_4d,
    };
  }
}

Future<List<Test>> _fromFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot<Map<String, dynamic>> snapshot =
      await firestore.collection("test").orderBy('s_time').get();
  List<Test> result =
      snapshot.docs.map((e) => Test.fromJson(e.data())).toList();
  return result;
}
