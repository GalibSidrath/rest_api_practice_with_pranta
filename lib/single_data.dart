import 'package:flutter/material.dart';

class SingleData extends StatelessWidget {
  final String url, title,id;
  const SingleData({super.key, required this.url, required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Single Photo'),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(url),
              SizedBox(height: 14,),
              Text('Title : $title'),
              Text('Id : $id')
            ],
          ),
        ),
      ),
    );
  }
}
