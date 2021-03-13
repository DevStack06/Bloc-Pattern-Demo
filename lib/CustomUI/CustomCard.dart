import 'package:flutter/material.dart';
import 'package:infotech/Model/DataModel.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key key, this.dataModel}) : super(key: key);
  final DataModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueGrey,
            child: Text(
              dataModel.id,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          title: Text(
            dataModel.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            dataModel.avatar,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
            ),
          ),
          trailing: Text(
            dataModel.createdAt.substring(11, 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 80),
          child: Divider(
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
