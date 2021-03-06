import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/views/widget/list_helper_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class MyFollowerPage extends FetchRefreshListViewPage<MyFollowerController> {
  MyFollowerPage() : super(title: '关注我的');

  @override
  Widget buildChild() {
    var data = controller.value.data;
    return AnimationListWidget(
      itemCount: data.length,
      itemBuilder: (_, i) {
        return UserFollowTileWidget(user: data[i]);
      },
    );
  }

  @override
  Widget buildEmpty() {
    return NothingPage(
      top: 50,
      text: "暂无关注者",
    );
  }
}
