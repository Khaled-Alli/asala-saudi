import 'package:asala_saudi/core/helpers/colors/colors.dart';
import 'package:asala_saudi/core/helpers/extentions/extentions.dart';
import 'package:asala_saudi/feature/presentation/home/widgets/payment_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../core/networking/web_services.dart';
import '../../../../core/routing/routing.dart';
import '../../../model/product/product.dart';

class MyPaymentButton extends StatefulWidget {
  const MyPaymentButton({
    super.key,
    required this.isVisa,
    required this.product,
  });

  final bool isVisa;
  final Product product;
  @override
  State<MyPaymentButton> createState() => _MyPaymentButtonState();
}

class _MyPaymentButtonState extends State<MyPaymentButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()async{
          if (widget.isVisa) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (context) => PaymentSheet(product: widget.product),
            );
          } else {
            await WebServices().purchaseProduct(widget.product.id!);
            await WebServices().getUser();
            context.pop();
            setState((){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الشراء بنجاح!')),);
            });
          }
        },
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: ShapeDecoration(
            color: AppColors.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              "Continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    //   BlocConsumer<PaymentCubit, PaymentState>(
    //   listener: (context, state) {
    //     if (state is PaymentSuccess) {
    //       Navigator.of(context)
    //           .pushReplacement(MaterialPageRoute(builder: (context) {
    //         return const ThankYouView();
    //       }));
    //     }
    //
    //     if (state is PaymentFailure) {
    //       Navigator.of(context).pop();
    //       SnackBar snackBar = SnackBar(content: Text(state.errMessage));
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     }
    //   },
    //   builder: (context, state) {
    //     return CustomButton(
    //         onTap: () {
    //           if (isPaypal) {
    //             var transctionsData = getTransctionsData();
    //             exceutePaypalPayment(context, transctionsData);
    //           } else {
    //             excuteStripePayment(context);
    //           }
    //         },
    //         isLoading: state is PaymentLoading ? true : false,
    //         text: 'Continue');
    //   },
    // );
  }
}
// void excuteStripePayment(BuildContext context) {
//   PaymentIntentInputModel paymentIntentInputModel = PaymentIntentInputModel(
//     amount: '100',
//     currency: 'USD',
//     cusomerId: 'cus_Onu3Wcrzhehlez',
//   );
//   BlocProvider.of<PaymentCubit>(context)
//       .makePayment(paymentIntentInputModel: paymentIntentInputModel);
// }
//
// void exceutePaypalPayment(BuildContext context,
//     ({AmountModel amount, ItemListModel itemList}) transctionsData) {
//   Navigator.of(context).push(MaterialPageRoute(
//     builder: (BuildContext context) => PaypalCheckoutView(
//       sandboxMode: true,
//       clientId: ApiKeys.clientID,
//       secretKey: ApiKeys.paypalSecretKey,
//       transactions: [
//         {
//           "amount": transctionsData.amount.toJson(),
//           "description": "The payment transaction description.",
//           "item_list": transctionsData.itemList.toJson(),
//         }
//       ],
//       note: "Contact us for any questions on your order.",
//       onSuccess: (Map params) async {
//         log("onSuccess: $params");
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) {
//             return const ThankYouView();
//           }),
//               (route) {
//             if (route.settings.name == '/') {
//               return true;
//             } else {
//               return false;
//             }
//           },
//         );
//       },
//       onError: (error) {
//         SnackBar snackBar = SnackBar(content: Text(error.toString()));
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) {
//             return const MyCartView();
//           }),
//               (route) {
//             return false;
//           },
//         );
//       },
//       onCancel: () {
//         print('cancelled:');
//         Navigator.pop(context);
//       },
//     ),
//   ));
// }