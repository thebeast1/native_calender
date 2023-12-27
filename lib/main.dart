/// TODO::: add_2_calendar not working as needed

/// TODO:::: manage_calendar_events not working as needed also
//
// import 'package:flutter/material.dart';
// import 'package:manage_calendar_events/manage_calendar_events.dart';
// import 'calender_list.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: CalendarPluginCheck());
//   }
// }
//
// class CalendarPluginCheck extends StatelessWidget {
//   final CalendarPlugin _myPlugin = CalendarPlugin();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _myPlugin.hasPermissions().then((value) {
//               if (!value!) {
//                 _myPlugin.requestPermissions();
//               } else {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => CalendarList()));
//               }
//             });
//           },
//           child: Text('Show Calendarss'),
//         ),
//       ),
//     );
//   }
// }

///TODO :: Try device_calendar doesn't work on ios

// import 'package:flutter/material.dart';
//
// import 'common/app_routes.dart';
// import 'presentation/pages/calendars.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(),
//       themeMode: ThemeMode.system,
//       darkTheme: ThemeData.dark(),
//       routes: {
//         AppRoutes.calendars: (context) {
//           return const CalendarsPage(key: Key('calendarsPage'));
//         }
//       },
//     );
//   }
// }

/// TODO ::: Try alarm_calendar

/*
 * @Author: 21克的爱情
 * @Date: 2020-04-28 16:50:26
 * @Email: raohong07@163.com
 * @LastEditors: 21克的爱情
 * @LastEditTime: 2021-02-04 19:46:06
 * @Description:
 */

import 'package:alarm_calendar/alarm_calendar_plugin.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Calendars calendars = Calendars(
      DateTime(2024,1,1,9),
      DateTime(2024,1,1,2),
      'Hail - Riyadh',
      'Hail',
      [120],
      //alert
      '1',///event id
      0); // all day

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('add event'),
                onPressed: () {
                  createEvent(calendars);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('get event'),
                onPressed: () {
                  selectEvent(calendars.getEventId);
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('edit event'),
                onPressed: () async {
                  calendarsInit();
                  final id = await AlarmCalendar.updateEvent(calendars);
                  print("edit event id：$id");
                  calendars.setEventId = id!;
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('delete event'),
                onPressed: () async {
                  final status =
                      await AlarmCalendar.deleteEvent(calendars.getEventId);
                  print("deleted status：$status");
                  calendars.setEventId = '';
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calendarsInit() {
    //更新参数
    calendars.setTitle = '测试通知修改版';
    calendars.setAlert = [3, 15];
    calendars.setStartTime = new DateTime.now();
    calendars.setEndTime = new DateTime.now().add(new Duration(days: 2));
    calendars.setAllDay = 0;
    calendars.setNote = '这里是备注内容';
  }

  Future<void> createEvent(Calendars calendars) async {
    //查询是否有读权限。
    await AlarmCalendar.CheckReadPermission().then((res) async {
      if (res != null) {
        //查询是否有写权限
        await AlarmCalendar.CheckWritePermission().then((resWrite) async {
          if (resWrite != null) {
            final id = await AlarmCalendar.createEvent(calendars);
            calendars.setEventId = id!;
            print('获得ID为：' + id);
          }
        });
      }
    });
  }

  Future<void> selectEvent(String id) async {
    //查询是否有读权限。
    await AlarmCalendar.CheckReadPermission().then((res) async {
      if (res != null) {
        //查询是否有写权限
        await AlarmCalendar.CheckWritePermission().then((resWrite) async {
          if (resWrite != null) {
            final result = await AlarmCalendar.selectEvent(id);
            print('获取返回数据：$result');
          }
        });
      }
    });
  }
}
