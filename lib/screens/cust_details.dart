import 'package:banking_app/data/data_model.dart';
import 'package:banking_app/screens/payment.dart';
import 'package:banking_app/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/data/database.dart';

class CustDetails extends StatefulWidget {
  CustDetails(
      {this.customer,
      this.positon,
      this.name,
      this.mail,
      this.bal,
      this.number});

  final positon;
  final name;
  final mail;
  final bal;
  final number;
  final customer;
  @override
  _CustDetailsState createState() => _CustDetailsState();
}

class _CustDetailsState extends State<CustDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Customer"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Colors.white,
                elevation: 12,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_rounded,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "${widget.name}",
                        style:
                            TextStyle(fontSize: 20, color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              buildCardList(context, widget.name, widget.positon, widget.mail,
                  widget.number, widget.bal),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 60.0,
                width: 250.0,
                child: GestureDetector(
                  onTap: () async {
                    List<Customer> customers = await DatabaseHelper.instance
                        .getUsersForTransfer(widget.positon);
                    showDialog(
                        context: context,
                        builder: (ctx) => transferWidget(
                            customers, widget.customer, context));
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(37.0),
                    shadowColor: Colors.grey,
                    color: Colors.white,
                    elevation: 7.0,
                    child: Center(
                      child: Text(
                        'Transfer Money',
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
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget transferWidget(
    List<Customer> customers, Customer customer, BuildContext context) {
  return SimpleDialog(
    title: Text('Choose Customer'),
    children: List.generate(
        customers.length,
        (index) => SimpleDialogOption(
              child: Text(customers[index].name),
              onPressed: () => showDialog(
                  context: context,
                  builder: (ctx) => TransferMoneyWidget(
                        transferFrom: customer,
                        transferTo: customers[index],
                      )),
            )),
  );
}

class TransferMoneyWidget extends StatefulWidget {
  final Customer transferFrom, transferTo;
  TransferMoneyWidget({Key key, this.transferFrom, this.transferTo})
      : super(key: key);

  @override
  _TransferMoneyWidgetState createState() =>
      _TransferMoneyWidgetState(transferFrom, transferTo);
}

class _TransferMoneyWidgetState extends State<TransferMoneyWidget> {
  final Customer transferFrom, transferTo;

  _TransferMoneyWidgetState(this.transferFrom, this.transferTo);

  TextEditingController _transferamount = TextEditingController();
  bool isAmountValid = false;
  double amount;

  void correctAmount() {
    if (_transferamount.text.isEmpty ||
        (double.parse(_transferamount.text) <= 0 ||
            double.parse(_transferamount.text) > transferFrom.bal)) {
      setState(() {
        isAmountValid = true;
        amount = double.parse(_transferamount.text);
      });

      return;
    } else {
      amount = double.parse(_transferamount.text);
      transferAmount(
              transferFrom, transferTo, double.parse(_transferamount.text))
          .then((value) {
        FocusScope.of(context).unfocus();
        _transferamount.clear();
        print(amount);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Payment(
                      customer_name: transferFrom.name,
                      reciever_name: transferTo.name,
                      amount: amount.toString(),
                    )));
      });
    }
  }

  Future<void> transferAmount(
      Customer transferFrom, Customer transferTo, double amountTransfer) async {
    double newTransferFromBal = transferFrom.bal - amountTransfer;
    double newTransferToBal = transferTo.bal + amountTransfer;

    try {
      await DatabaseHelper.instance.insertTransfer(Transfer(
          transferFrom: transferFrom.name,
          transferTo: transferTo.name,
          amountTransfer: amountTransfer));
      await DatabaseHelper.instance.updateUsers(Customer(
          pos: transferFrom.pos,
          name: transferFrom.name,
          mail: transferFrom.mail,
          bal: newTransferFromBal,
          phone: transferFrom.phone));
      await DatabaseHelper.instance.updateUsers(Customer(
          pos: transferTo.pos,
          name: transferTo.name,
          mail: transferTo.mail,
          bal: newTransferToBal,
          phone: transferTo.phone));
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBarTheme(
        data: ButtonBarThemeData(alignment: MainAxisAlignment.spaceEvenly),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          title: Text(
            'Transfer Money',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Transfer from: '),
                  Text(transferFrom.name)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Transfer to: '),
                  Text(transferTo.name)
                ],
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: _transferamount,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Amount',
                    errorText: isAmountValid ? 'Invalid Amount' : null),
              ),
            ],
          ),
          actions: [
            OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue),
                )),
            OutlinedButton(
                onPressed: () => correctAmount(),
                child:
                    Text('Transfer Now', style: TextStyle(color: Colors.blue))),
          ],
        ));
  }
}
