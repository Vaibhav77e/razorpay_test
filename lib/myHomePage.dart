import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Paymnet Successfull: ${response.paymentId}",
        timeInSecForIosWeb: 4);
  }

  void _handleErrorPaymnet(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg:
            "Payment Failed please try again : ${response.code} ,${response.code}",
        timeInSecForIosWeb: 4);
  }

  void _walletName(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "Unexpected Error occured: ${response.walletName}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handleErrorPaymnet);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _walletName);
  }

  void makePayment() async {
    var options = {
      'key': 'rzp_test_56vsphxuqqup6K',
      'amount': '5000',
      'name': 'Vaibhavv.C',
      'desc': 'Beautiful Nature',
      'prefill': {'contact': '+917348849521', 'email': 'vaibhavc9980@gmail.com'}
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView(
        children: [
          Card(
              child: ListTile(
            leading: Image.network(
                'https://cdn.pixabay.com/photo/2023/05/19/05/33/boats-8003723_1280.jpg'),
            title: const Text('Beautiful Image'),
            trailing: ElevatedButton(
                onPressed: () {
                  makePayment();
                },
                child: const Text('Pay')),
          ))
        ],
      ),
    );
  }
}
