//
// import 'package:flutter/material.dart';
//
// class PaymentSheet extends StatefulWidget {
//   final double totalAmount;
//
//   const PaymentSheet({super.key, required this.totalAmount});
//
//   @override
//   State<PaymentSheet> createState() => _PaymentSheetState();
// }
//
// class _PaymentSheetState extends State<PaymentSheet> {
//   final cardNumberController = TextEditingController();
//   final expiryController = TextEditingController();
//   final cvcController = TextEditingController();
//   final zipController = TextEditingController();
//
//   String selectedCountry = 'United States';
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         left: 24,
//         right: 24,
//         top: 12,
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildHandle(),
//             const SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Add your payment information",
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildCardInfoSection(),
//             const SizedBox(height: 24),
//             _buildBillingAddressSection(),
//             const SizedBox(height: 24),
//             _buildPayButton(),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCardInfoSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Card information", style: TextStyle(fontWeight: FontWeight.w500)),
//         const SizedBox(height: 8),
//         _buildTextField(
//           hint: "Card number",
//           suffix: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset('assets/images/visa.png', height: 16),
//               const SizedBox(width: 4),
//               Image.asset('assets/images/mastercard.png', height: 16),
//             ],
//           ),
//           controller: cardNumberController,
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(child: _buildTextField(hint: "MM / YY", controller: expiryController)),
//             const SizedBox(width: 12),
//             Expanded(child: _buildTextField(hint: "CVC", controller: cvcController)),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildBillingAddressSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Billing address", style: TextStyle(fontWeight: FontWeight.w500)),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: selectedCountry,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.grey.shade100,
//
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//           isExpanded: true,
//           items: ['United States', 'Canada',"Saudi Arabia", 'Egypt',"Kuwait" ,"United Arab Emirates"]
//               .map((country) => DropdownMenuItem(value: country, child: Text(country)))
//               .toList(),
//           onChanged: (val) {
//             setState(() => selectedCountry = val!);
//           },
//         ),
//         const SizedBox(height: 12),
//         _buildTextField(hint: "ZIP Code", controller: zipController),
//       ],
//     );
//   }
//
//   Widget _buildTextField({
//     required String hint,
//     TextEditingController? controller,
//     Widget? suffix,
//   }) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.grey.shade100,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         suffixIcon: suffix != null
//             ? Padding(padding: const EdgeInsets.only(right: 8), child: suffix)
//             : null,
//       ),
//     );
//   }
//
//   Widget _buildPayButton() {
//     return ElevatedButton.icon(
//       onPressed: null, // simulate lock
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue,
//         minimumSize: const Size.fromHeight(50),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//       icon: const Icon(Icons.lock, color: Colors.white),
//       label: Text(
//         "Pay \$${widget.totalAmount.toStringAsFixed(2)}",
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }
//
//   Widget _buildHandle() {
//     return Container(
//       width: 40,
//       height: 5,
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
// }


import 'package:asala_saudi/core/helpers/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/networking/web_services.dart';
import '../../../../core/routing/routing.dart';
import '../../../model/product/product.dart';

class PaymentSheet extends StatefulWidget {
  final Product product;

  const PaymentSheet({super.key, required this.product});

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();
  final zipController = TextEditingController();

  String selectedCountry = 'Saudi Arabia';

  final List<String> countries = [
    // 🌍 Arabic
    "Saudi Arabia", "United Arab Emirates", "Egypt", "Qatar", "Bahrain",
    "Kuwait", "Oman", "Yemen", "Jordan", "Syria", "Iraq", "Lebanon",
    "Palestine", "Sudan", "Libya", "Algeria", "Morocco", "Tunisia",
    "Mauritania", "Somalia", "Comoros", "Djibouti",

    // 🌍 European
    "Germany", "France", "United Kingdom", "Italy", "Spain",
    "Netherlands", "Sweden", "Norway", "Switzerland", "Greece"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 12,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHandle(),
            const SizedBox(height: 8),
            const SizedBox(height: 12),
            Text(
              "Add your payment information",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildCardInfoSection(),
            const SizedBox(height: 28),
            _buildBillingAddressSection(),
            const SizedBox(height: 24),
            _buildPayButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCardInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Card information", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: cardNumberController,
          decoration: InputDecoration(
            hintText: "Card number",
            prefixIcon: const Icon(Icons.credit_card),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/visa.png', height: 16),
                  const SizedBox(width: 4),
                  Image.asset('assets/images/mastercard.png', height: 16),
                ],
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTextField(hint: "MM / YY", controller: expiryController)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(hint: "CVC", controller: cvcController)),
          ],
        ),
      ],
    );
  }

  Widget _buildBillingAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Billing address", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedCountry,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          isExpanded: true,
          items: countries
              .map((country) => DropdownMenuItem(value: country, child: Text(country)))
              .toList(),
          onChanged: (val) => setState(() => selectedCountry = val!),
        ),
        const SizedBox(height: 12),
        _buildTextField(hint: "ZIP Code", controller: zipController),
      ],
    );
  }

  Widget _buildTextField({
    required String hint,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildPayButton() {
    return ElevatedButton.icon(
      onPressed: ()async{
        await WebServices().purchaseProduct(widget.product.id!);
        await WebServices().getUser();
        context.pop();
        context.pop();
        setState((){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الشراء بنجاح!')),);
        });
      }, // simulate lock
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: const Icon(Icons.lock, color: Colors.white),
      label: Text(
        "Pay \$${widget.product.price}",
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
