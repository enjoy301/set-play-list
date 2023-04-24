import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/MyIdolController.dart';

class IdolSelectScreen extends StatefulWidget {
  const IdolSelectScreen({Key? key}) : super(key: key);

  @override
  State<IdolSelectScreen> createState() => _IdolSelectScreen();
}

class _IdolSelectScreen extends State<IdolSelectScreen> {
  late final SharedPreferences prefs;
  Map<int, dynamic> searchList = {
    0: {"id": 0, "name": "장원영/아이브", "isSelected": false},
    1: {"id": 1, "name": "김채원/르세라핌", "isSelected": false},
    2: {"id": 2, "name": "리즈/아이브", "isSelected": false},
    3: {"id": 3, "name": "하니/뉴진스", "isSelected": false},
  };
  List<int> selectList = [];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyIdolController());

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListView.builder(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   // padding: EdgeInsets.only(right: double.infinity),
          //   itemCount: selectList.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Row(
          //       children: [
          //         Container(
          //           margin: EdgeInsets.only(left: 15, top: 15),
          //           padding: EdgeInsets.all(20),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(40),
          //             color: Color(0xFF27282B),
          //           ),
          //           child: InkWell(
          //             onTap: () {
          //               debugPrint("wow");
          //             },
          //             child: Text(
          //               searchList[selectList[index]]["name"],
          //               style: TextStyle(
          //                 fontFamily: 'Cafe24',
          //                 color: Color(0xFF72B8AB),
          //                 fontWeight: FontWeight.w800,
          //                 fontSize: 13,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(30),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color(0xFF27282B),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "아티스트 검색",
                    style: TextStyle(
                      fontFamily: 'Cafe24',
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "아티스트",
                    hintStyle: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Cafe24',
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 10,
                      right: 15,
                      bottom: 10,
                      left: 15,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Cafe24',
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 40,
                        child: ListTile(
                          title: Text(
                            searchList[index]["name"],
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Cafe24',
                              color: controller.isMyIdol(index)
                                  ? Color(0xFF72B8AB)
                                  : Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onTap: () {
                            if (!searchList[index]["isSelected"]) {
                              selectList.add(index);
                              controller.addIdol(index);
                            } else {
                              selectList.remove(index);
                              controller.removeIdol(index);
                            }
                            searchList[index]["isSelected"] =
                                !searchList[index]["isSelected"];
                            setState(
                              () => {},
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      controller.carouselController.value.jumpToPage(0);
                      controller.setCurrentPage(0);
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      side: BorderSide(
                        color: Color(0xFF72B8AB),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: selectList.isEmpty
                          ? Color(0xFF27282B)
                          : Color(0xFF72B8AB),
                    ),
                    child: Text(
                      "선택하기",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Cafe24',
                        color: selectList.isEmpty
                            ? Color(0xFF72B8AB)
                            : Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _sharedPreferencesInit();
  }

  _sharedPreferencesInit() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      searchList[0]["isSelected"] = prefs.getBool("0") ?? false;
      searchList[1]["isSelected"] = prefs.getBool("1") ?? false;
      searchList[2]["isSelected"] = prefs.getBool("2") ?? false;
      searchList[3]["isSelected"] = prefs.getBool("3") ?? false;
    });
  }
}
