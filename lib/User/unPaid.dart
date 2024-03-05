import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';

import 'checkout.dart';

const Color yellow = Color(0xffFDC054);
const Color mediumYellow = Color(0xffFDB846);
const Color darkYellow = Color(0xffE99E22);
const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);
const Color darkGrey = Color(0xff202020);
int curr = 1;
int currPrice = 1;

const LinearGradient mainButton = LinearGradient(
  colors: [
    Color(0xFF800065), // Blue Violet
    Color(0xFF800080), // Purple
  ],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);
const LinearGradient tealGradient = LinearGradient(
  colors: [
    Color(0xFF008080), // Teal// Dark Turquoise
    Color(0xFF008065), // Light Sea Green
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

class UnpaidPage extends StatefulWidget {
  final String id;
  final String event_name;
  final String event_image;
  final String event_price;
UnpaidPage({
  required this.id,
  required this.event_name,
  required this.event_image,
  required this.event_price,
});
  @override
  _UnpaidPageState createState() => _UnpaidPageState();
}

class _UnpaidPageState extends State<UnpaidPage> {

  @override
  void didUpdateWidget(covariant UnpaidPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset the quantity and price when the widget is updated
    curr = 1;
    currPrice = int.parse(widget.event_price) * curr;
  }
  @override
  initState(){
    super.initState();
    curr = 1;
    currPrice = int.parse(widget.event_price) * curr;
    print(currPrice);
  }

  @override
  Widget build(BuildContext context) {
    Widget payNow = InkWell(
      onTap: () {
        // Add your payment logic here
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaymentPage()));
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: Theme.of(context).brightness == Brightness.dark ? mainButton : tealGradient,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(50.0)),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme
                .of(context)
                .primaryColor,
            // Choose appropriate colors for dark and light mode
            onPrimary: Colors.white,
            // Text color
            padding: EdgeInsets.symmetric(
                horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text("Confirm",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                     CheckoutPage(id: widget.id,event_name: widget.event_name,event_price: '$currPrice',count:'$curr')
                    // UnpaidPage(id: widget.id, event_name: widget.event_name, event_image: widget.event_image, event_price: widget.event_price,),

              ),
            );
            // Your button's onPressed logic here
          },
        ),
      ),
    );

    return Material(
      // color: Colors.white,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Unpaid',
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CloseButton()
                        ],
                      ),
                    ),
                    // Add your product items or details here
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding:
                      const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .brightness == Brightness.dark
                            ? Colors.grey.shade800
                            : Colors.white,
                        boxShadow: shadow,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Example product list tile
                          ListTile(
                            title: Text(widget.event_name),
                            trailing: Text(
                              widget.event_price == '0'
                                  ? 'Free'
                                  : '₹ ' + NumberFormat('#,##,##0').format(
                                  int.parse(widget.event_price)),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          InputQty.int(
                            maxVal: 10,
                            initVal: 1,
                            steps: 1,
                            minVal: 1,
                            qtyFormProps: QtyFormProps(enableTyping: false),
                            // messageBuilder: (minVal,maxVal,val) {
                            //   if (val != null){
                            //     return Text("Value:$val");
                            //   }
                            //   // curr = val;
                            //   // print(curr);// num
                            //   // currPrice = (int.parse(widget.event_price) * curr);
                            //   // // print((int.parse(widget.event_price)) * curr.round());
                            //   // print(currPrice);
                            // },
                            onQtyChanged: (val) {
                              setState(() {
                                curr = val;
                                // Update the total price based on quantity
                                currPrice = int.parse(widget.event_price) * curr;
                              });
                            },
                            decoration: QtyDecorationProps(
                              isBordered: false,
                              minusBtn: Icon(
                                Icons.remove,
                                // color: Colors.purple,
                              ),
                              plusBtn:
                              Icon(Icons.add,
                                  // color: Colors.indigo
                              ),

                            ),
                          ),
                          SizedBox(width: 30),
                          // Add more ListTile for each product
                          Divider(),
                          ListTile(
                            title: Text('Total',style: GoogleFonts.alexandria(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            ),),
                            trailing: Text('₹ ' + NumberFormat('#,##,##0').format(
                                currPrice),
                            style: GoogleFonts.alexandria(
                              color: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ),
                          // Add other details like Tax, Promo Code, etc.
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: payNow,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
