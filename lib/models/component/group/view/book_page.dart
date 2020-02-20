import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_book_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_topic_data.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class BookPage extends StatefulWidget {
  BookPage({Key key, this.bookJson}) : super(key: key);
  final GroupBookJson bookJson;

  @override
  _BookPageState createState() => _BookPageState(bookJson: bookJson);
}

class _BookPageState extends State<BookPage> {
  _BookPageState({Key key, this.bookJson});
  GroupBookJson bookJson;

  @override
  Widget build(BuildContext context) {
    return bookJson == null
        ? loading()
        : bookJson.data.isEmpty
            ? loading()
            : SingleChildScrollView(
                child: aniColumn(
                  aniWhich: 4,
                  children: [SizedBox(height: 155)]
                    ..addAll(bookJson.data.map((a) {
                      return oneBook(context, a);
                    }).toList()),
                ),
              );
  }
}

Widget oneBook(BuildContext context, BookData data) {
  return GestureDetector(
    onTap: () {
      // openUrl(context, "https://www.yuque.com/${data.login}");
    },
    child: Container(
      height: 70,
      margin: EdgeInsets.only(left: 15, top: 2, bottom: 8, right: 15),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(1, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 20),
          Container(
            margin: EdgeInsets.only(left: 6),
            child: iconType[data.type],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.only(left: 20),
            child: (data.description != null) && (data.description != "")
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          clearText(data.name, 10),
                          style: AppStyles.textStyleB,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        child: Text(
                          "${clearText(data.description, 15)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textStyleC,
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Text(
                      "${data.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyleB,
                    ),
                  ),
          ),
          Spacer(),
          // FollowButtom(data: data)
        ],
      ),
    ),
  );
}

Map<String, Icon> iconType = {
  "Doc": Icon(
    Icons.description,
    color: Colors.deepPurpleAccent,
  ),
  "Book": Icon(
    Icons.book,
    color: Colors.blue,
  ),
  "Sheet": Icon(
    Icons.event_note,
    color: Colors.green,
  ),
  "Thread": Icon(
    Icons.speaker_notes,
    color: Colors.blue,
  ),
  "Group": Icon(
    Icons.group,
    color: Colors.grey,
  ),
  "Design": Icon(
    Icons.collections,
    color: Colors.orangeAccent,
  ),
  "Resource": Icon(
    Icons.create_new_folder,
    color: Colors.orangeAccent,
  ),
  "Column": Icon(
    Icons.chrome_reader_mode,
    color: Colors.limeAccent,
  ),
};