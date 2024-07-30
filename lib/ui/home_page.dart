import 'package:flutter/material.dart';
import '../network/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  List<Map<String,dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    List<Map<String, dynamic>> data = await _apiService.fetchData();
    setState(() {
      _items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/logs');
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return ListTile(
              title: Text(item['name']),
              subtitle: item['data'] != null ? Text("color: ${item['data']['color']}, Capacity: ${item['data']['capacity']}") : Text("No additional data"),
            );
          },
      ),
    );
  }
}