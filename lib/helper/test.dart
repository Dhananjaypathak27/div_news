import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  bool _isAsyncCall = true;
  
  callDemoApi() async{
    await Future.delayed(Duration(
      seconds: 5
    ),(){

      setState(() {
        _isAsyncCall = false;
        print('_isAsyncCall');
      });
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    callDemoApi();
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isAsyncCall,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: _loginText(context),
        ),
      ),
    );
  }
}
Widget _loginText(BuildContext context){
  return Text('hello');
}
