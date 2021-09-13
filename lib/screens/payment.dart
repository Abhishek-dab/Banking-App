import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  Payment({
    this.customer_name,
    this.reciever_name,
    this.amount,
  });
  final String customer_name;
  final String reciever_name;
  final String amount;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(
              child: Icon(
                Icons.receipt_long,
                color: Colors.white,
                size: 100,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "\u20B9${widget.amount}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Payment Successful",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Transaction Details",
                  style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.blue,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Text(
                      "From: ${widget.customer_name}",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.blue,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Text(
                      "To: ${widget.reciever_name}",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              color: Colors.blue,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Text(
                      "Amount: \u20B9${widget.amount}",
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 60.0,
              width: 155.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Material(
                  borderRadius: BorderRadius.circular(42.0),
                  shadowColor: Colors.grey,
                  color: Colors.white,
                  elevation: 4,
                  child: Center(
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
