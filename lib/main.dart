import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Hayden Calc'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String counter = "";
  double number1 = 0.0;
  double number2 = 0.0;
  int oneOrTwo = 1;
  int decimal = -1;
  String op = "";

  void _evaluate(){
    setState(() {
      if(op=='+'){
        number1=number1+number2;
      }
      else if(op=='-'){
        number1=number1-number2;
      }
      else if(op=='*'){
        number1=number1*number2;
      }
      else if(op=='/'){
        number1=number1/number2;
      }
      else if(op=='%'){
        number1=number1/100;
      }
      else if(op=='C'){
        number1=0.0;
      }
      counter=number1.toString();
      number2=0.0;
      oneOrTwo=1;
      op="";
      decimal=-1;
    });
  }

  void _incrementOp(String oper){
    setState(() {
      if(oper=='='){
        _evaluate();
        return;
      }
      else if(oper=='D'){
        if(op!=''){
          op='';
          oneOrTwo=1;
          counter=number1.toString();

        }
        else if(oneOrTwo==1){
          String temp = number1.toString();
          if(number1%1!=0){
              temp = temp.substring(0,temp.length-1);
          }
          else{
            decimal=-1;
            if(number1<10.0){
              temp='0.0';
            }
            else{
              temp = temp.substring(0,temp.length-3);
            }
          }
          number1=double.parse(temp);
          counter=number1.toString();
        }
        else if(oneOrTwo==2){
          number2=0.0;
          counter=number1.toString()+op;
        }
        return;
      }
      op=oper;
      if(oneOrTwo==2 || oper=='%' || oper=='C'){
        _evaluate();
        return;
      }
      else{
        oneOrTwo=2;
        decimal=-1;
      }
      counter=counter+oper;
    });
  }

  void _incrementNumber(String added) {
    setState(() {
      if(added=='_'){
        if(oneOrTwo==1){
          number1=number1*-1.0;
          counter=number1.toString();
        }
        else if(oneOrTwo==2){
          number2=number2*-1.0;
          counter=number1.toString()+op+number2.toString();
        }
        return;
      }
      double newNum = double.parse(added);
      if(oneOrTwo==1){
        if(decimal!=-1){
          decimal++;
          newNum=newNum/pow(10.0,decimal);
        }
        else{
          number1=number1*10.0;
        }
        number1 += (newNum);
        counter=number1.toString();
      }
      else if(oneOrTwo==2) {
        if (decimal != -1) {
          decimal++;
          newNum = newNum / pow(10.0,decimal);
        }
        else {
          number2 = number2 * 10.0;
        }
        number2 += (newNum);
        counter=number1.toString()+op+number2.toString();
      }

    });
  }

  void _startDecimal(){
    setState(() {
      decimal=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(5.0)),
            new Text(
              '$counter',
              style: Theme.of(context).textTheme.display1,
            ),
            new Padding(padding: new EdgeInsets.all(20.0)),
            makeButtonTop(10.0,Colors.blue, Colors.blue, 'C', 'D', '%', '='),
            new Padding(padding: new EdgeInsets.all(10.0)),
            makeButtonRowNum(10.0,Colors.green, Colors.blue, '7', '8', '9', '/'),
            new Padding(padding: new EdgeInsets.all(10.0)),
            makeButtonRowNum(10.0,Colors.green, Colors.blue, '4', '5', '6', '*'),
            new Padding(padding: new EdgeInsets.all(10.0)),
            makeButtonRowNum(10.0,Colors.green, Colors.blue, '3', '2', '1', '-'),
            new Padding(padding: new EdgeInsets.all(10.0)),
            makeButtonBottom(10.0,Colors.green, Colors.blue, '_', '0', '.', '+'),
            new Padding(padding: new EdgeInsets.all(10.0)),



          ],


        ),
      ),
    );
  }

  Widget makeButtonRowNum(double spacing, Color color1, Color color2, String op1, String op2, String op3, String op4){
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        makeButtonNum(color1, op1),

        new Padding(padding: new EdgeInsets.all(spacing)),
        makeButtonNum(color1, op2),

        new Padding(padding: new EdgeInsets.all(spacing)),
        makeButtonNum(color1, op3),

        new Padding(padding: new EdgeInsets.all(spacing)),
        makeButtonOp(color2, op4),
      ],
    );
  }
  Widget makeButtonTop(double spacing, Color color1, Color color2, String op1, String op2, String op3, String op4){
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        makeButtonOp(color1, op1),

        new Padding(padding: new EdgeInsets.all(spacing)),
        makeButtonOp(color1, op2),

        new Padding(padding: new EdgeInsets.all(spacing)),
        makeButtonOp(color1, op3),

        new Padding(padding: new EdgeInsets.all(spacing)),
        makeButtonOp(color2, op4),
      ],
    );
  }
  Widget makeButtonBottom(double spacing, Color color1, Color color2, String op1, String op2, String op3, String op4){
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        makeButtonNum(color1, op1),

        new Padding(padding: new EdgeInsets.all(spacing)),
        makeButtonNum(color1, op2),

        new Padding(padding: new EdgeInsets.all(spacing)),
        makeButtonDec(color1, op3),

        new Padding(padding: new EdgeInsets.all(spacing)),
        makeButtonOp(color2, op4),
      ],
    );
  }

  FloatingActionButton makeButtonNum(Color color, String op){
    return new FloatingActionButton(
      backgroundColor: color,
      onPressed: () => _incrementNumber(op),
      child: new Text(op,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35.0,
        ),
      ),
    );
  }

  FloatingActionButton makeButtonOp(Color color, String op) {
    return new FloatingActionButton(
      backgroundColor: color,
      onPressed: () => _incrementOp(op),
      child: new Text(op,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35.0,
        ),
      ),
    );
  }
  FloatingActionButton makeButtonDec(Color color, String op){
    return new FloatingActionButton(
      backgroundColor: color,
      onPressed: () => _startDecimal(),
      child: new Text(op,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35.0,
        ),
      ),
    );
  }
}



