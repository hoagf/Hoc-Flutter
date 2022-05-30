import 'dart:ffi';

class Transaction{
  String content;
  double amount;
  Transaction({required this.content, required this.amount});

  @override
  String toString() {
    return 'Content: $content Amount: $amount';
  }
}