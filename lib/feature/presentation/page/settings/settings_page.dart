import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newstoday/feature/presentation/widget/social_account.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: WidgetAppBar(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(48.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Interface',
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Use dark mode',
                        style: TextStyle(
                          fontSize: 42.sp,
                        ),
                      ),
                      Text(
                        'Get that whiteness out',
                        style: TextStyle(
                          fontSize: 36.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: Hive.box('settings').listenable(),
                  builder: (context, box, widget) {
                    var isDarkMode = box.get('darkMode') ?? false;
                    return Switch(
                      value: isDarkMode,
                      onChanged: (value) async {
                        isDarkMode = value;
                        await box.put('darkMode', isDarkMode);
                      },
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SocialAccount(),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Made with ♥ in India',
                  style: TextStyle(
                    fontSize: 42.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        var isDarkMode = box.get('darkMode') ?? false;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Talk to NewsToday Developer',
              style: TextStyle(
                fontSize: 42.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            SocialAccounts(color: isDarkMode ? Colors.white : Colors.black87),
          ],
        );
      },
    );
  }
}

class WidgetAppBar extends PreferredSize {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, box, widget) {
        var isDarkMode = box.get('darkMode') ?? false;
        return isDarkMode
            ? AppBar(
                title: Text('Settings'),
              )
            : AppBar(
                title: Text('Settings'),
              );
      },
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}
