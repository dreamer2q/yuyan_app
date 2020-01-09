import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_small/user_event.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';

Widget toDoc(BuildContext context, Data data) {
  print(data.avatarUrl);
  return Container(
    margin: EdgeInsets.only(top: 7),
    padding: EdgeInsets.only(top: 7, bottom: 7),
    decoration: BoxDecoration(
      color: AppColors.background,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(128, 116, 116, 116),
          offset: Offset(0, 0),
          blurRadius: 1,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 18, right: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 46,
                margin: EdgeInsets.only(right: 3),
                child: userEvent(
                    userImg: data.avatarUrl,
                    title: data.who,
                    event: "${data.who}${data.did}",
                    time: timeCut(data.when)),
              ),
              Container(
                margin: EdgeInsets.only(top: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "${data.event[0].title}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColors.accentText,
                          fontFamily: "PingFang SC",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7),
                      child: Text(
                        data.event[0].description,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Color.fromARGB(255, 89, 89, 89),
                          fontFamily: "PingFang SC",
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
