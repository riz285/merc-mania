// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:merc_mania/consts.dart';

import '../../core/configs/themes/app_colors.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({required this.message, required this.success});
}

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  static getPlatformExceptionErrorResult(e) {
    String message = 'Something went wrong';
    if (e.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return StripeTransactionResponse(
      message: message,
      success: false
    );
  }

  // Combine method for PaymentIntent and PaymentMethod
  Future<void> makePayment(int amount, String userId) async {
  try {
    String? paymentIntentClientSecret = await createPaymentIntent(amount: amount);

    if (paymentIntentClientSecret == null) return;
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: true,
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'Merc Mania demo',
        appearance: PaymentSheetAppearance(          
          colors: PaymentSheetAppearanceColors(
            background: AppColors.darkPrimary,
            primary: AppColors.primary,
            componentBorder: AppColors.primary
          ),
          shapes: PaymentSheetShape(
            borderWidth: 2,
            shadow: PaymentSheetShadowParams(color: AppColors.primary)
          ),
          primaryButton: PaymentSheetPrimaryButtonAppearance(
            shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
            colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: AppColors.lightBackground,
                text: AppColors.title,
                border: AppColors.primary
              ),
              dark: PaymentSheetPrimaryButtonThemeColors(
                background: AppColors.primary,
                text: AppColors.darkPrimary,
                border: AppColors.primary
              ),
            )
          )
        ),
        preferredNetworks: [CardBrand.Mastercard, CardBrand.Visa],
        // intentConfiguration: IntentConfiguration(mode: IntentMode.setupMode(setupFutureUsage: IntentFutureUsage.OffSession))
      ),
    );
    await processPayment();
  } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Payment Intent
  Future<String?> createPaymentIntent(
    {required int amount}) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        'amount': amount.toString(),
        'currency': 'vnd',
        'payment_method_types[]' : 'card',
      };
      var response = await dio.post('https://api.stripe.com/v1/payment_intents',
      data: data,
      options: Options(contentType: Headers.formUrlEncodedContentType,
      headers: {
        'Authorization': 'Bearer $stripeSecretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      }));
      if (response.data != null) {
        print(response.data);
        return response.data['client_secret'] ;
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
      
    } on StripeException catch (e) {
      print(e);
      rethrow;
    }
  }

  

}

// class StripeService {
//   static String apiBase = 'https://api.stripe.com/v1';
//   static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
//   static Map<String, String> headers = {
//     'Authorization': 'Bearer $stripeSecretKey',
//     'Content-Type': 'application/x-www-form-urlencoded'
//   };

//   static init() {
//     StripePayment.setOptions(
//       StripeOptions(
//         publishableKey: stripePublishableKey,
//         merchantId: "Test",
//         androidPayMode: 'test'
//       )
//     );
//   }

//   static Future<StripeTransactionResponse> payViaExistingCard(String amount, String currency, CreditCard card) async{
//     try {
//       var paymentMethod = await StripePayment.createPaymentMethod(
//         PaymentMethodRequest(card: card)
//       );
//       var paymentIntent = await StripeService.createPaymentIntent(
//         amount,
//         currency
//       );
//       var response = await StripePayment.confirmPaymentIntent(
//         PaymentIntent(
//           clientSecret: paymentIntent['client_secret'],
//           paymentMethodId: paymentMethod.id
//         )
//       );
//       if (response.status == 'succeeded') {
//         return new StripeTransactionResponse(
//           message: 'Transaction successful',
//           success: true
//         );
//       } else {
//         return new StripeTransactionResponse(
//           message: 'Transaction failed',
//           success: false
//         );
//       }
//     } on PlatformException catch(e) {
//       return StripeService.getPlatformExceptionErrorResult(e);
//     } catch (e) {
//       return new StripeTransactionResponse(
//         message: 'Transaction failed: ${e.toString()}',
//         success: false
//       );
//     }
//   }

//   static Future<StripeTransactionResponse> payWithNewCard({String amount, String currency}) async {
//     try {
//       var paymentMethod = await StripePayment.paymentRequestWithCardForm(
//         CardFormPaymentRequest()
//       );
//       var paymentIntent = await StripeService.createPaymentIntent(
//         amount,
//         currency
//       );
//       var response = await StripePayment.confirmPaymentIntent(
//         PaymentIntent(
//           clientSecret: paymentIntent['client_secret'],
//           paymentMethodId: paymentMethod.id
//         )
//       );
//       if (response.status == 'succeeded') {
//         return new StripeTransactionResponse(
//           message: 'Transaction successful',
//           success: true
//         );
//       } else {
//         return new StripeTransactionResponse(
//           message: 'Transaction failed',
//           success: false
//         );
//       }
//     } on PlatformException catch(e) {
//       return StripeService.getPlatformExceptionErrorResult(e);
//     } catch (e) {
//       return new StripeTransactionResponse(
//         message: 'Transaction failed: ${e.toString()}',
//         success: false
//       );
//     }
//   }

//   static getPlatformExceptionErrorResult(e) {
//     String message = 'Something went wrong';
//     if (e.code == 'cancelled') {
//       message = 'Transaction cancelled';
//     }

//     return new StripeTransactionResponse(
//       message: message,
//       success: false
//     );
//   }

//   static Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//       var response = await http.post(
//         StripeService.paymentApiUrl,
//         body: body,
//         headers: StripeService.headers
//       );
//       return jsonDecode(response.body);
//     } catch (e) {
//       print('e charging user: ${e.toString()}');
//     }
//     return null;
//   }
// }
