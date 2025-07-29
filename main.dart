
// نسخه آزمایشی اپلیکیشن فحله پلاس - مرحله اول
// امکانات: ثبت ورود/خروج، محاسبه مدت زمان کاری، نمایش لیست، طراحی ساده فارسی

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(FahlehPlusApp());
}

class FahlehPlusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'فحله پلاس',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Vazir',
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: HomePage(),
    );
  }
}

class WorkEntry {
  DateTime startTime;
  DateTime? endTime;

  WorkEntry({required this.startTime, this.endTime});

  Duration get duration => endTime == null ? Duration.zero : endTime!.difference(startTime);

  String get formattedDuration {
    final d = duration;
    return '${d.inHours.toString().padLeft(2, '0')}:${(d.inMinutes % 60).toString().padLeft(2, '0')}';
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WorkEntry> entries = [];
  WorkEntry? currentEntry;

  void startWork() {
    setState(() {
      currentEntry = WorkEntry(startTime: DateTime.now());
    });
  }

  void endWork() {
    setState(() {
      if (currentEntry != null) {
        currentEntry!.endTime = DateTime.now();
        entries.add(currentEntry!);
        currentEntry = null;
      }
    });
  }

  String formatDateTime(DateTime dt) {
    return DateFormat('yyyy/MM/dd – HH:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('فحله پلاس - نسخه آزمایشی'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentEntry == null)
                ElevatedButton(
                  onPressed: startWork,
                  child: Text('شروع کار'),
                )
              else
                ElevatedButton(
                  onPressed: endWork,
                  child: Text('پایان کار'),
                ),
              SizedBox(height: 20),
              Text('سابقه فعالیت‌ها:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final e = entries[index];
                    return Card(
                      child: ListTile(
                        title: Text('از ${formatDateTime(e.startTime)} تا ${e.endTime != null ? formatDateTime(e.endTime!) : '-'}'),
                        subtitle: Text('مدت: ${e.formattedDuration}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
