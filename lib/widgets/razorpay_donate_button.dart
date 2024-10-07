import 'dart:ui' as ui; // Correct import for Flutter Web
import 'package:flutter/material.dart';
import 'dart:html' as html;

class RazorpayButtonWidget extends StatefulWidget {
  const RazorpayButtonWidget({super.key});

  @override
  _RazorpayButtonWidgetState createState() => _RazorpayButtonWidgetState();
}

class _RazorpayButtonWidgetState extends State<RazorpayButtonWidget> {
  @override
  void initState() {
    super.initState();

    // Register the view for HTML content using `platformViewRegistry`
    // This line makes sure that the HTML content is rendered properly in Flutter Web
    ui.platformViewRegistry.registerViewFactory(
      'razorpay-button',
      (int viewId) => html.IFrameElement()
        ..style.border = 'none'
        ..src = 'data:text/html;charset=utf-8,${Uri.encodeComponent('''
          <form id="razorpayForm">
            <script src="https://checkout.razorpay.com/v1/payment-button.js"
                    data-payment_button_id="pl_P64KmF1mv766yX"
                    async>
            </script>
          </form>
        ''')}'
        ..style.width = '100%'
        ..style.height = '100%',
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 200,
      height: 220,
      child: HtmlElementView(viewType: 'razorpay-button'),
    );
  }
}
