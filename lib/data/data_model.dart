class Customer {
  final int pos;
  final String name;
  final String mail;
  final double bal;
  final String phone;

  const Customer({this.pos, this.name, this.mail, this.bal, this.phone});

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
      pos: json["pos"],
      name: json["name"],
      mail: json["mail"],
      bal: json["bal"],
      phone: json["phone"]);

  Map<String, dynamic> toMap() {
    return {
      'pos': pos,
      'name': name,
      'mail': mail,
      'bal': bal,
      'phone': phone,
    };
  }
}

class Transfer {
  final int pos;
  final String transferFrom;
  final String transferTo;
  final double amountTransfer;

  Transfer({this.pos, this.transferFrom, this.transferTo, this.amountTransfer});

  factory Transfer.fromMap(Map<String, dynamic> json) => Transfer(
        pos: json["pos"],
        transferFrom: json["transferFrom"],
        transferTo: json["transferTo"],
        amountTransfer: json["amountTransfer"],
      );

  Map<String, dynamic> toMap() {
    return {
      'pos': pos,
      'transferFrom': transferFrom,
      'transferTo': transferTo,
      'amountTransfer': amountTransfer,
    };
  }
}

const DATA = const [
  Customer(
      pos: 1,
      name: 'Abhishek',
      mail: 'abhishek@cyz.com',
      bal: 50000,
      phone: '9999999999'),
  Customer(
      pos: 2,
      name: 'Aahan',
      mail: 'aahan@cyz.com',
      bal: 20000,
      phone: '9865321254'),
  Customer(
      pos: 3,
      name: 'Parth',
      mail: 'parth@cyz.com',
      bal: 75000,
      phone: '8965321535'),
  Customer(
      pos: 4,
      name: 'Aakil',
      mail: 'aakil@cyz.com',
      bal: 12000,
      phone: '8765435498'),
  Customer(
      pos: 5,
      name: 'Karan',
      mail: 'karan@cyz.com',
      bal: 33000,
      phone: '8956232154'),
  Customer(
      pos: 6,
      name: 'Aadhya',
      mail: 'aadhya@cyz.com',
      bal: 65000,
      phone: '9865321245'),
  Customer(
      pos: 7,
      name: 'Brinda',
      mail: 'brinda@cyz.com',
      bal: 39000,
      phone: '3265984512'),
  Customer(
      pos: 8,
      name: 'Aarohi',
      mail: 'aarohi@cyz.com',
      bal: 45000,
      phone: '1245879865'),
  Customer(
      pos: 9,
      name: 'Saanvi',
      mail: 'saanvi@cyz.com',
      bal: 56650,
      phone: '7845123265'),
  Customer(
      pos: 10,
      name: 'Ishika',
      mail: 'ishika@cyz.com',
      bal: 49300,
      phone: '6532124578'),
];
