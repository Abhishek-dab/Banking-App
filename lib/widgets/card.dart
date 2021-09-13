import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

String na, mails, numb;
double bal;
int po;
Widget buildCardList(BuildContext context, String name, int pos, String mail,
    String number, double balance) {
  na = name;
  po = pos;
  mails = mail;
  numb = number;
  bal = balance;

  return Container(
    color: Colors.transparent,
    height: 200,
    width: double.infinity,
    child: FlipCard(
      direction: FlipDirection.VERTICAL,
      front: buildFrontFace(context),
      back: buildBackFace(context),
    ),
  );
}

Widget buildFrontFace(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xFFFF9800), Color(0xFF9C2700)]),
          borderRadius: new BorderRadius.circular(15)),
      width: (MediaQuery.of(context).size.width) - 50,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            right: 10,
            child: Container(
              width: 90,
              height: 60,
              child: Text(
                '\u20B9${bal.toString()}',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 25,
            child: Text(
              "Sparks Bank",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Positioned(
            bottom: 55,
            left: 25,
            child: Text(
              "1234   XXXX   XXXX   XXXX",
              style: TextStyle(color: Colors.white, fontSize: 17.5),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 25,
            child: Text(
              na,
              style: TextStyle(color: Colors.grey[200], fontSize: 14.5),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 50,
            child: Text(
              'ID: $po',
              style: TextStyle(color: Colors.grey[200], fontSize: 14.5),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildBackFace(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xFFFF9800), Color(0xFF9C2700)]),
          borderRadius: new BorderRadius.circular(15)),
      width: (MediaQuery.of(context).size.width) - 50,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 25,
            child: Text(
              "Phone Number: $numb",
              style: TextStyle(color: Colors.white, fontSize: 12.25),
            ),
          ),
          Positioned(
            top: 45,
            left: 0,
            child: Container(
              width: (MediaQuery.of(context).size.width) - 30,
              height: 40,
              color: Colors.black,
            ),
          ),
          Positioned(
            top: 100,
            left: 10,
            right: 50,
            child: Container(
              width: (MediaQuery.of(context).size.width) - 30,
              height: 40,
              color: Colors.white,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: Text(
                      "XXX",
                      style: TextStyle(color: Colors.black, fontSize: 12.25),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 25,
            child: Text(
              "Email ID: $mails",
              style: TextStyle(color: Colors.white, fontSize: 12.25),
            ),
          ),
        ],
      ),
    ),
  );
}
