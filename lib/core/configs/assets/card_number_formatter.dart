import 'package:flutter/services.dart';

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text.replaceAll(' ', '');
    var newTextSplit = '';
    var newTextLength = newText.length;

    int splitCount = 0;
    for (int i = 0; i < newTextLength; i++) {
      if (splitCount < 4) {
        newTextSplit += newText[i];
      } else if (splitCount == 4) {
        newTextSplit += ' ${newText[i]}';
        splitCount = 0;
      } 
        splitCount++;
    }
    return  TextEditingValue(
        text: newTextSplit,   // final generated credit card number
        selection: TextSelection.collapsed(offset: newTextSplit.length) // keep the cursor at end
    );
  }
}