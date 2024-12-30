import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latte/bottompages/secondpage/secondpage.dart';
import 'package:latte/size_config.dart';

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
      theme: ThemeData(
        fontFamily: 'MangoDdobak',
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      color: const Color.fromARGB(255, 252, 246, 248),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 252, 246, 248),
          shape: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 251, 221, 231),
              width: 1,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('$_month월 $_day일',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
        ),
        body: FutureBuilder(
          future: _fromFirestore(),
          builder: (context, snapshot) => ListView(
              children: List.generate(snapshot.data?.length ?? 1, (index) {
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              CameraPosition position = CameraPosition(
                  target: LatLng(
                      double.parse(snapshot.data?[index].coordinate_3d ?? '0'),
                      double.parse(snapshot.data?[index].coordinate_4d ?? '0')),
                  zoom: 15);
              return Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      // border:
                      //     Border.all(color: Color.fromARGB(255, 237, 53, 108))),
                      color: Color.fromARGB(255, 250, 230, 237)),
                  margin: EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: Container(
                    child: Column(
                      children: [
                        ExpansionTile(
                          title: Text(
                            '${snapshot.data?[index].s_time} ~ ${snapshot.data?[index].e_time}',
                            style: const TextStyle(
                                fontSize: 19,
                                fontFamily: 'MangoDdobak',
                                color: Colors.black),
                          ),
                          trailing: Text(
                            snapshot.data?[index].title ?? "111",
                            style: const TextStyle(
                                fontSize: 19,
                                fontFamily: 'MangoDdobak',
                                color: Colors.black),
                          ),
                          children: <Widget>[
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: const Column(
                                        children: [
                                          Text(
                                            '기간',
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '시간',
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '장소',
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '요금',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10)),
                                        Text(
                                            '${snapshot.data?[index].s_date} ~ ${snapshot.data?[index].e_date}'),
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10)),
                                        Text(
                                            '${snapshot.data?[index].s_time} ~ ${snapshot.data?[index].e_time}'),
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10)),
                                        Text(
                                            '${snapshot.data?[index].location}'),
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10)),
                                        Text('${snapshot.data?[index].fee}'),
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10)),
                                      ],
                                    ),
                                    Container(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          '${snapshot.data?[index].image}',
                                          // width: 100,
                                          // height: 100,
                                          scale: 2.7,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 247, 207, 223))),
                                  padding: EdgeInsets.all(1),
                                  child: ClipRRect(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: getProportionateScreenHeight(310),
                                      width: getProportionateScreenWidth(310),
                                      child: GoogleMap(
                                        initialCameraPosition: position,
                                        mapType: MapType.normal,
                                        myLocationButtonEnabled: false,
                                        markers: {
                                          Marker(
                                            markerId: const MarkerId('1'),
                                            position: LatLng(
                                                double.parse(snapshot
                                                        .data?[index]
                                                        .coordinate_3d ??
                                                    '0'),
                                                double.parse(snapshot
                                                        .data?[index]
                                                        .coordinate_4d ??
                                                    '0')),
                                          ),
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: getProportionateScreenHeight(10))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          })),
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
