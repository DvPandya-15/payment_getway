import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PayHome extends StatefulWidget {
  const PayHome({Key? key}) : super(key: key);

  @override
  _PayHomeState createState() => _PayHomeState();
}

class _PayHomeState extends State<PayHome> {
  Razorpay razorpay = new Razorpay();
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckOut() {
    var options = {
      //TODO: put  this key in env
      "key": "rzp_test_uKkRjJ8kerzlUb",
      "amount": textEditingController.text,
      "name": "Payment App",
      "description": "Payment",
      "prefill": {
        "contact": "9824343803",
        "email": "dvpandya2138433@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    Fluttertoast.showToast(msg: "Payment Successful", textColor: Colors.black);
  }

  void handlerPaymentError() {
    Fluttertoast.showToast(msg: "Payment Error", textColor: Colors.black);
  }

  void handlerExternalWallet() {
    Fluttertoast.showToast(msg: "External Wallet", textColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment System"),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "Amount",
            ),
          ),
          SizedBox(height: 12),
          TextButton(
            style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () {
              openCheckOut();
            },
            child: Text("Pay Now"),
          ),
        ],
      ),
    );
  }
}
