import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class UPIScreen extends StatefulWidget {

  final double amount;

  const UPIScreen({required this.amount});

  @override
  _UPIScreenState createState() => _UPIScreenState();
}

class _UPIScreenState extends State<UPIScreen> {

  final String upiId = 'paytmqr5ztmx0@ptys';
  final String payeeName = 'Smart Cart Vision Group';



  @override
  Widget build(BuildContext context) {

    String upiUrl =
        'upi://pay?pa=$upiId&pn=$payeeName&am=${widget.amount}&cu=INR';

    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI QR Code'),
      ),
      body: Column(
        children: [
          SizedBox(height: 40,),
          Center(
            child: QrImageView(
              data: upiUrl,
              version: QrVersions.auto,
              size: 300.0,
              errorStateBuilder: (context, error) {
                return const Center(
                  child: Text(
                    'Error generating QR code',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async{
                      if (await canLaunch(upiUrl)) {
                        await launch(upiUrl);
                      } else {
                        throw 'Could not launch UPI URL';
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
