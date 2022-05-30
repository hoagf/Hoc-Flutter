import 'package:flutter/cupertino.dart';
import 'package:hocjhlutter/Transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget{
 final List<Transaction> transactions;
  TransactionList({required this.transactions});
  ListView _buildWidgetList(){
   return ListView.builder(
     itemCount: transactions.length,
       itemBuilder: (context, index){
     return Card(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10),
       ),
       color:  (index%2==0)?Colors.deepOrangeAccent:Colors.teal,
       elevation: 10,
       child: ListTile(
         leading: const Icon(Icons.account_box),
         title: Text(transactions[index].content,
           style: const TextStyle(
             color: Colors.white,
             fontWeight: FontWeight.bold,
             fontSize: 20,
           ),),
         subtitle: Text('Price ${transactions[index].amount}',
           style: const TextStyle(
               fontSize: 15,
               fontWeight: FontWeight.normal,
               color: Colors.white
           ),),
         onTap: (){
           print('Tap');
         },
       ),
     );
   });
 }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: _buildWidgetList(),
    );
  }

}