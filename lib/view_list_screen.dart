import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api/GetDataModel.dart';
import 'package:rest_api/single_data.dart';

class ViewList extends StatefulWidget {
  const ViewList({super.key});

  @override
  State<ViewList> createState() => _ViewListState();
}

class _ViewListState extends State<ViewList> {
  List<GetDataModel> mydata = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
      ),
      body: ListView.builder(
          itemCount: mydata.length,
          itemBuilder: (context, index) {
            return _buildData(mydata[index]);
          }),
    );
  }

  Widget _buildData(GetDataModel data){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: (){
          String url,title, id;
          url = data.url.toString();
          title = data.title.toString();
          id = data.id.toString();
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SingleData(url: url, title: title, id: id);
          }));
        },
        child: ListTile(
          leading: Image.network(data.thumbnailUrl.toString()),
          title: Wrap(children: [Text(data.title.toString())]),
        ),
      ),
    );
  }

  Future<void> _getData() async {
    mydata.clear();
    String Url = 'https://jsonplaceholder.typicode.com/photos';
    Uri uri = Uri.parse(Url);
    Response response = await get(uri);

    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      final List getData = decodeData;
      for (Map i in getData) {
        // The_Data thedata = The_Data(
        //     title: i['title'],
        //     url: i['url'],
        //     thumb: i['thumbnailUrl'],
        //     id: i['id']);
        mydata.add(GetDataModel.fromJson(i));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Unable to get data')));
    }

    setState(() {});
  }
}

// class The_Data {
//   String title;
//   String url;
//   String thumb;
//   int id;
//
//   The_Data(
//       {required this.title,
//       required this.url,
//       required this.thumb,
//       required this.id});
// }
