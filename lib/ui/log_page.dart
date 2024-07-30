import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class LogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            debugPrint('Error loading logs: ${snapshot.error}');
            return Center(child: Text('Error loading logs.'));
          }

          if (!snapshot.hasData || (snapshot.data ?? []).isEmpty) {
            debugPrint('No logs found.');
            return Center(child: Text('No logs found.'));
          }

          final logs = snapshot.data!;
          return ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return ListTile(
                  title: Text(log['date']),
                  subtitle: Text(log['response']),
                );
              }
          );
        },
      ),
    );
  }
}