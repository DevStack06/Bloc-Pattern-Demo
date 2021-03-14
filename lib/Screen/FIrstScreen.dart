import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotech/CustomUI/CustomCard.dart';
import 'package:infotech/Model/DataModel.dart';
import 'package:infotech/bloc/post_bloc.dart';

class FirstScreen extends StatefulWidget {
  final List<DataModel> allData;
  FirstScreen({Key key, this.allData}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("All data"),
      ),
      body: widget.allData.isEmpty
          ? Center(
              child: Text("No data avaialble"),
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return CustomCard(dataModel: widget.allData[index]);
              },
              itemCount: widget.allData.length,
            ),
    );
  }
}

// BlocBuilder<PostBloc, PostState>(
//       builder: (context, state) {

//         if (state is PostSuccess) {
//           if (state.posts.isEmpty) {
//             return Center(
//               child: Text('no posts'),
//             );
//           }
//           return ListView.builder(
//             itemBuilder: (BuildContext context, int index) {
//               return CustomCard(dataModel: state.posts[index]);
//             },
//             itemCount: state.posts.length,
//           );
//         }
//       },
//     );
