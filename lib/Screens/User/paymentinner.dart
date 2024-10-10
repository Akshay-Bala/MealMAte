
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';



// class Cardpayment extends StatefulWidget {
//   const Cardpayment({super.key});

//   @override
//   State<StatefulWidget> createState() => MySampleState();
// }

// class MySampleState extends State<Cardpayment> {
//   bool isLightTheme = false;
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   bool useFloatingAnimation = true;
//   final OutlineInputBorder border = OutlineInputBorder(
//     borderSide: BorderSide(
//       color: Colors.grey.withOpacity(0.7),
//       width: 2.0,
//     ),
//   );
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
//     );
//     return MaterialApp(
//       title: 'Flutter Credit Card View Demo',
//       debugShowCheckedModeBanner: false,
//       themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
//       theme: ThemeData(
//         textTheme: const TextTheme(
//           // Text style for text fields' input.
//           titleMedium: TextStyle(color: Colors.black, fontSize: 18),
//         ),
//         colorScheme: ColorScheme.fromSeed(
//           brightness: Brightness.light,
//           seedColor: Colors.white,
//           background: Colors.black,
//           // Defines colors like cursor color of the text fields.
//           primary: Colors.black,
//         ),
//         // Decoration theme for the text fields.
//         inputDecorationTheme: InputDecorationTheme(
//           hintStyle: const TextStyle(color: Colors.black),
//           labelStyle: const TextStyle(color: Colors.black),
//           focusedBorder: border,
//           enabledBorder: border,
//         ),
//       ),
//       darkTheme: ThemeData(
//         textTheme: const TextTheme(
//           // Text style for text fields' input.
//           titleMedium: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//         colorScheme: ColorScheme.fromSeed(
//           brightness: Brightness.dark,
//           seedColor: Colors.black,
//           background: Colors.white,
//           // Defines colors like cursor color of the text fields.
//           primary: Colors.white,
//         ),
//         // Decoration theme for the text fields.
//         inputDecorationTheme: InputDecorationTheme(
//           hintStyle: const TextStyle(color: Colors.black54),
//           labelStyle: const TextStyle(color: Colors.black54),
//           focusedBorder: border,
//           enabledBorder: border,
//         ),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(onPressed: (){
//             Navigator.of(context).pop();
//           }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
//         ),
//         resizeToAvoidBottomInset: false,
//         body: Builder(
//           builder: (BuildContext context) {
//             return Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: ExactAssetImage(
//                     isLightTheme ? 'assets/images/bg-light.png' : 'assets/images/bg-dark.png',
//                   ),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               child: SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: <Widget>[
//                     CreditCardWidget(
//                       cardNumber: cardNumber,
//                       expiryDate: expiryDate,
//                       cardHolderName: cardHolderName,
//                       cvvCode: cvvCode,
//                       //bankName: 'Axis Bank',
//                       frontCardBorder: useGlassMorphism
//                           ? null
//                           : Border.all(color: Colors.black),
//                       backCardBorder: useGlassMorphism
//                           ? null
//                           : Border.all(color: Colors.black),
//                       showBackView: isCvvFocused,
//                       obscureCardNumber: true,
//                       obscureCardCvv: true,
//                       isHolderNameVisible: true,
//                       cardBgColor: isLightTheme
//                           ? AppColors.cardBgLightColor
//                           : AppColors.cardBgColor,
//                       backgroundImage:'assets/images/card_bg.png',
//                           //useBackgroundImage ? 'assets/images/card_bg.png' :,
//                       isSwipeGestureEnabled: true,
//                       onCreditCardWidgetChange:
//                           (CreditCardBrand creditCardBrand) {},
//                       customCardTypeIcons: <CustomCardTypeIcon>[
//                         CustomCardTypeIcon(
//                           cardType: CardType.mastercard,
//                           cardImage: Image.asset(
//                             'assets/images/mastercard.png',
//                             height: 48,
//                             width: 48,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: <Widget>[
//                             CreditCardForm(
//                               formKey: formKey,
//                               obscureCvv: true,
//                               obscureNumber: true,
//                               cardNumber: cardNumber,
//                               cvvCode: cvvCode,
//                               isHolderNameVisible: true,
//                               isCardNumberVisible: true,
//                               isExpiryDateVisible: true,
//                               cardHolderName: cardHolderName,
//                               expiryDate: expiryDate,
//                               inputConfiguration: const InputConfiguration(
//                                 cardNumberDecoration: InputDecoration(
//                                   labelText: 'Number',
//                                   hintText: 'XXXX XXXX XXXX XXXX',
//                                 ),
//                                 expiryDateDecoration: InputDecoration(
//                                   labelText: 'Expired Date',
//                                   hintText: 'XX/XX',
//                                 ),
//                                 cvvCodeDecoration: InputDecoration(
//                                   labelText: 'CVV',
//                                   hintText: 'XXX',
//                                 ),
//                                 cardHolderDecoration: InputDecoration(
//                                   labelText: 'Card Holder',
//                                 ),
//                               ),
//                               onCreditCardModelChange: onCreditCardModelChange,
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   const Text('Card Image'),
//                                   const Spacer(),
//                                   Switch(
//                                     value: useBackgroundImage,
//                                     inactiveTrackColor: Colors.grey,
//                                     activeColor: Colors.white,
//                                     activeTrackColor: AppColors.colorE5D1B2,
//                                     onChanged: (bool value) => setState(() {
//                                       useBackgroundImage = value;
//                                     }),
//                                   ),
//                                 ],
//                               ),
//                             ),
                            
//                             const SizedBox(height: 20),
//                             GestureDetector(
//                             //  onTap: _onValidate,
//                               child: Container(
//                                 margin: const EdgeInsets.symmetric(
//                                   horizontal: 16,
//                                   vertical: 8,
//                                 ),
//                                 decoration: const BoxDecoration(
//                                   color: AppColors.colorB58D67,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(8),
//                                   ),
//                                 ),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                                 alignment: Alignment.center,
//                                 child: const Text(
//                                   'Pay',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'halter',
//                                     fontSize: 14,
//                                     package: 'flutter_credit_card',
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

 

//   Glassmorphism? _getGlassmorphismConfig() {
//     if (!useGlassMorphism) {
//       return null;
//     }

//     final LinearGradient gradient = LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
//       stops: const <double>[0.3, 0],
//     );

//     return isLightTheme
//         ? Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient)
//         : Glassmorphism.defaultConfig();
//   }

//   void onCreditCardModelChange(CreditCardModel creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }
// }

// final c1 = Color.fromARGB(228, 249, 246, 246) ;

// class AppColors {
//   static const Color backgroundColor = Color(0xFFFFFFFF);
//   static const Color lightBlue = Color(0xFF4C9EEB);
//   static const Color darkText = Colors.purpleAccent;
//   static const Color myCartBackgroundColor = Colors.cyan;
//   AppColors._();

//   static const Color cardBgColor = Colors.black;
//   static const Color cardBgLightColor = Colors.black;
//   static const Color colorB58D67 = Color.fromARGB(255, 98, 204, 236);
//   static const Color colorE5D1B2 = Color.fromARGB(255, 98, 204, 236);
//   static const Color colorF9EED2 = Color.fromARGB(255, 98, 204, 236);
//   static const Color colorEFEFED = Color.fromARGB(255, 98, 204, 236);
// }