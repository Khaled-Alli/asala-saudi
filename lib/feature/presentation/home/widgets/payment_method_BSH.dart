import 'package:asala_saudi/feature/model/product/product.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/my_payment_button.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/payment_method_list_view.dart';
import 'package:flutter/material.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet(this.product);
  final Product product;
  @override
  State<PaymentMethodsBottomSheet> createState() => PaymentMethodsBottomSheetState();
}

class PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  bool isVisa = false;

  updatePaymentMethod({required int index}) {
    if (index == 0) {
      isVisa = false;
    } else {
      isVisa = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(updatePaymentMethod: updatePaymentMethod,),
          const SizedBox(height: 32,),
          MyPaymentButton(
            isVisa: isVisa,
            product: widget.product,
          ),
        ],
      ),
    );
  }
}
