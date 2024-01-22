// import 'package:ecommerce_int2/screens/select_card_page.dart';
import 'package:event_management/User/paymentPage.dart';
import 'package:flutter/material.dart';

const Color yellow = Color(0xffFDC054);
const Color mediumYellow = Color(0xffFDB846);
const Color darkYellow = Color(0xffE99E22);
const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);
const Color darkGrey = Color(0xff202020);

const LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(236, 60, 3, 1),
  Color.fromRGBO(234, 60, 3, 1),
  Color.fromRGBO(216, 78, 16, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

class AddAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget finishButton = InkWell(
      onTap:()=> Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => PaymentPage())),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Finish",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkGrey),
        title: Text(
          'Billing Address',
          style: const TextStyle(
              // color: darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
            BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).padding.bottom == 0
                      ? 20
                      : MediaQuery.of(context).padding.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AddAddressForm(),
                  Center(child: finishButton)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class AddAddressForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              // color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Flat Number/House Number'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              // color: Colors.white,
            ),
            child: TextField(
              decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Street'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Area',
                  style: TextStyle(fontSize: 12, color: darkGrey),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Container(
                  padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.orange, width: 2)),
                    color: Colors.orange[100],
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name on card',
                      hintStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              // color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Name on card'),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: Container(
              padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.red, width: 1)),
                // color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Postal code'),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: true,
                onChanged: (_) {},
              ),
              Text('Add this to address bookmark')
            ],
          )
        ],
      ),
    );
  }
}