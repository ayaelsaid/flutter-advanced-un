import 'package:flutter/material.dart';
import 'package:paymob_payment/paymob_payment.dart';
import 'package:using_firebase/utilis/color_utilis.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv for environment variables

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.arrow_back_ios_new_sharp),
            SizedBox(
              width: 80,
            ),
            Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Card(
              color: isSelected ? Colors.white : ColorUtility.grayLight,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: ListTile(
                title: Text(
                  'Paymob',
                  style: TextStyle(
                    color: isSelected ? ColorUtility.deepYellow : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    setState(() {
                      isSelected = !isSelected; // Toggle selection state
                    });

                    if (isSelected) {
                      // Initialize Paymob Payment
                      await PaymobPayment.instance.initialize(
                        apiKey: dotenv.env[
                            'apiKey']!, // Get API Key from environment variables
                        integrationID: int.parse(
                            dotenv.env['integrationID']!), // Integration ID
                        iFrameID:
                            int.parse(dotenv.env['iFrameID']!), // iFrame ID
                      );

                      // Perform payment
                      final PaymobResponse? response =
                          await PaymobPayment.instance.pay(
                        context: context,
                        currency: "EGP",
                        amountInCents: "20000", // Amount in cents (200 EGP)
                      );

                      if (response != null) {
                        print('Response: ${response.transactionID}');
                        print('Response: ${response.success}');
                      }
                    }
                  },
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: isSelected ? ColorUtility.deepYellow : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
