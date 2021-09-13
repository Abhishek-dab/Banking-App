import 'package:banking_app/data/data_model.dart';
import 'package:banking_app/screens/cust_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:banking_app/data/database.dart';

class CustomersScreen extends StatefulWidget {
  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseHelper>(
      builder: (context, _, ch) => FutureBuilder<List<Customer>>(
          future: DatabaseHelper.instance.getCustomers(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                        splashColor: Colors.blueAccent,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustDetails(
                                        customer: snapshot.data[index],
                                        positon: snapshot.data[index].pos,
                                        name: snapshot.data[index].name,
                                        mail: snapshot.data[index].mail,
                                        bal: snapshot.data[index].bal,
                                        number: snapshot.data[index].phone,
                                      )));
                        },
                        child: customersList(snapshot.data[index], ctx));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

Widget customersList(Customer customer, BuildContext ctx) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: Text(
            (customer.pos).toString(),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.blueAccent),
          ),
          trailing: Text(
            '\u20B9' + (customer.bal).toString(),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          title: Text(
            customer.name,
            style: new TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          subtitle: Text(
            customer.mail,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.blueAccent),
          ),
        ),
      ),
    ),
  );
}
