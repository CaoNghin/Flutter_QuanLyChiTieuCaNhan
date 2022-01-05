import 'package:daily_spending/constants/convert.dart';
import 'package:daily_spending/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  final int total;

  const AppDrawer({
    Key key,
    this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            'Quản lý chi tiêu cá nhân',
            style: Theme.of(context).appBarTheme.textTheme.headline1,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("Trang chủ"),
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    },
                  ),

                  ListTile(
                    leading: Image.asset(
                      'assets/images/github.png',
                      color: Colors.grey,
                    ),
                    title: Text("Github"),
                    onTap: () async {
                      String url = Uri.encodeFull(
                          "https://github.com/CaoNghin/Flutter_QuanLyChiTieuCaNhan.git");
                      if (await canLaunch(url)) {
                        Navigator.of(context).pop();
                        await launch(url);
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Tổng chi tiêu từ trước đến nay:\n   '

                    + Themdaucham(total) +" VNĐ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
