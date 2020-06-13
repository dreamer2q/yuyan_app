import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

class Guide3 extends StatefulWidget {
  Guide3({Key key}) : super(key: key);

  @override
  _Guide3State createState() => _Guide3State();
}

class _Guide3State extends State<Guide3> {
  int onPressedTimes;

  @override
  void initState() {
    super.initState();
    onPressedTimes = 0;
  }

  goLogin() {
    print(123);
    print(onPressedTimes);
    setState(() {
      onPressedTimes = onPressedTimes + 1;
    });
    if (onPressedTimes <= 2) {
      Navigator.of(context).pushNamed("/login");
    } else {
      return () {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/guide/guide3.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.21,
            child: Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: FlatButton(
                onPressed: goLogin,
                child: Text(
                  "使用语雀登录",
                  style: TextStyle(
                    color: AppColors.accentText,
                    fontFamily: "sans_bold",
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
