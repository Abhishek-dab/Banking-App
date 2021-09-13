import 'package:banking_app/data/data_model.dart';
import 'package:banking_app/data/database.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isData = false;

  @override
  void initState() {
    checkData();
    super.initState();
  }

  void checkData() async {
    var transferData = await DatabaseHelper.instance.getTransfers();
    if (transferData.isEmpty) {
      setState(() {
        isData = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isData
        ? Center(
            child: Text('No Transfer History Yet',
                style: TextStyle(color: Colors.white)),
          )
        : FutureBuilder<List<Transfer>>(
            future: DatabaseHelper.instance.getTransfers(),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                          splashColor: Colors.blueAccent,
                          child: transfersList(
                              snapshot.data[snapshot.data.length - index - 1],
                              ctx));
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
  }
}

Widget transfersList(Transfer transfer, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          dense: true,
          leading: Text(
            " From : ${transfer.transferFrom}",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          trailing: Text(
            " To : ${transfer.transferTo}",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          title: Text(
            "${'\u20B9' + (transfer.amountTransfer).toString()}",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          subtitle: Text(
            "---------->",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
        ),
      ),
    ),
  );
}
