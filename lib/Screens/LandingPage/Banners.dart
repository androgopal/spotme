import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String firebaseUrl = 'https://your-project-id.firebaseio.com/banners.json';

  Future<List<dynamic>> _fetchBannerList() async {
    final response = await http.get(Uri.parse(firebaseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.values.toList();
    } else {
      throw Exception('Failed to load banner list');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Banner List'),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: _fetchBannerList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final bannerList = snapshot.data ?? [];
              return ListView.builder(
                itemCount: bannerList.length,
                itemBuilder: (context, index) {
                  final banner = bannerList[index];
                  return ListTile(
                    leading: Image.network(banner['image']),
                    title: Text(banner['title']),
                    subtitle: Text(banner['description']),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
