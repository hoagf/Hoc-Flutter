import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hocjhlutter/TransactionList.dart';
import 'package:intl/intl.dart';
import 'package:hocjhlutter/Transaction.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}
class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  TextEditingController _contentController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Transaction _transaction = Transaction(content:'', amount:0.0);
  List<Transaction> _list = <Transaction>[];
  @override
  void initState(){
  super.initState();
  WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose(){
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state==AppLifecycleState.paused){
      print('App in background mode');
    }else if(state == AppLifecycleState.resumed){
      print('App in fontground mode');
    }
  }
  void _insertTransaction(){
    if(_transaction.content.isEmpty
    ||_transaction.amount==null
    ||_transaction.amount.isNaN) return;
    _list.add(_transaction);
    _transaction = Transaction(content: '', amount: 0.0);
    _amountController.text = '';
    _contentController.text = '';
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Xin Chaof Hoang day",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Day la app bar'),
          elevation: 3,
          actions: [
            IconButton(
                onPressed:(){
                  setState((){
                    _insertTransaction();
                  });
                },
                icon: Icon(Icons.add))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          tooltip: 'Insert transaction',
          onPressed: () {
            setState((){
              _insertTransaction();
            });
          },
          child: const Icon(Icons.add),

        ),
        key: _scaffoldKey,
        body: SafeArea(
          minimum: const EdgeInsets.only(left: 20, right: 20),
        child:  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Content'),
                controller: _contentController,
                onChanged: (text){
                  setState((){
                    _transaction.content = text;
                  });
                },),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onChanged: (text){
                  setState((){
                    _transaction.amount = double.tryParse(text) ?? 0;
                  });
                },),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              ButtonTheme(
                height: 80,
                child: FlatButton(
                  child: Text('Insert transaction'),
                  textColor: Colors.white,
                  color: Colors.brown,
                  onPressed: () {
                    _insertTransaction();
                    //   _scaffoldKey.currentState?.showSnackBar(
                    //     SnackBar(
                    //       content: Text('TransactionList: ${_list.toString()}'),
                    //       duration: Duration(seconds: 3),),
                    // );

                  },),),
              TransactionList(transactions: _list)
            ],
          ),
        )
        ),
      ),
    );
  }
}