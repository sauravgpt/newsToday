import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialAccounts extends StatelessWidget {
  final Color color;
  SocialAccounts({this.color});
  @override
  Widget build(BuildContext context) {
    return [
      Icon(
        AntDesign.linkedin_square,
        color: color,
      ).mdClick(() {
        launch("https://linkedin.com/in/sauravgpt");
      }).make(),
      20.widthBox,
      Icon(
        AntDesign.github,
        color: color,
      ).mdClick(() {
        launch("https://github.com/sauravgpt");
      }).make(),
      20.widthBox,
      Icon(
        AntDesign.twitter,
        color: color,
      ).mdClick(() {
        launch("https://twitter.com/sauravgpt");
      }).make(),
      20.widthBox,
      Icon(
        AntDesign.instagram,
        color: color,
      ).mdClick(() {
        launch("https://instagram.com/sauravgpt");
      }).make(),
      20.widthBox,
      Icon(
        AntDesign.facebook_square,
        color: color,
      ).mdClick(() {
        launch("https://facebook.com/sauravgpt");
      }).make(),
      20.widthBox,
      Icon(
        AntDesign.user,
        color: color,
      ).mdClick(() {
        launch("https://saurav-portfolio.web.app");
      }).make(),
    ].hStack();
  }
}
