import 'package:flutter/material.dart';
import 'package:simple_calc/calculate.dart';
import 'about_page.dart';
import 'odd_even.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 253, 84, 0))),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _CalculatorPage();
}

class _CalculatorPage extends State<SimpleCalculator> {
  final TextEditingController num1 = TextEditingController();
  final TextEditingController num2 = TextEditingController();

  String _result = "";
  String operator = "";
  double vat = 0.07;

  List <String> history = [];

  void clearHistory() {
    setState( () {
      history.clear();
    });
  }

  String calVat(double num1,String op,double num2 ){
    String result = calculate(num1, op, num2);
    double x = double.tryParse(result)??0;

    double total = x + (x*vat);
    return total.toString();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    Widget calculatorContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OddEven()),
            );
        }, 
        child: const Text('OddEven',style: TextStyle(fontSize: 32),)),
        const SizedBox(height: 20,),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ช่องกรอกตัวที่ 1
            Expanded(
              child: TextField(
                controller: num1,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ตัวเลข 1',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25)
                ),
              ),
            ),
            
            const SizedBox(width: 8),

            // ช่องแสดงเครื่องหมาย
            Expanded(child: Text(operator, style: const TextStyle(fontSize: 28), textAlign: TextAlign.center)),

            const SizedBox(width: 8),

            // ช่องกรอกตัวที่ 2
            Expanded(
              child: TextField(
                controller: num2,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'ตัวเลข 2',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25)
                ),
              ),
            ),

            const SizedBox(width: 8),

            const Expanded(child: Center(child: Text('=', style: TextStyle(fontSize: 28)))),
            
            const SizedBox(width: 8),

            // ช่องแสดงผล
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _result.isEmpty ? "0" : _result,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 25),

        // ปุ่มคำนวณและปุ่มเคลียร์
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = calculate(
                    double.tryParse(num1.text) ?? 0,
                    '+',
                    double.tryParse(num2.text) ?? 0,
                  );
                  history.insert(0,"${num1.text} + ${num2.text} = $_result");
                  operator = '+';
                });
              },
              child: const Text('+', style: TextStyle(fontSize: 28)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = calculate(
                    double.tryParse(num1.text) ?? 0,
                    '-',
                    double.tryParse(num2.text) ?? 0,
                  );
                  history.insert(0,"${num1.text} - ${num2.text} = $_result");
                  operator = '-';
                });
              },
              child: const Text('-', style: TextStyle(fontSize: 28)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = calculate(
                    double.tryParse(num1.text) ?? 0,
                    '*',
                    double.tryParse(num2.text) ?? 0,
                  );
                  history.insert(0,"${num1.text} x ${num2.text} = $_result");
                  operator = 'x';
                });
              },
              child: const Text('×', style: TextStyle(fontSize: 28)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = calculate(
                    double.tryParse(num1.text) ?? 0,
                    '/',
                    double.tryParse(num2.text) ?? 0,
                  );
                  history.insert(0,"${num1.text} ÷ ${num2.text} = $_result");
                  operator = '÷';
                });
              },
              child: const Text('÷', style: TextStyle(fontSize: 28)),
            ),
            ElevatedButton(
              onPressed: clearHistory,
              child: const Text('C', style: TextStyle(fontSize: 28)),
            ),
            ElevatedButton(
              onPressed: (){
                if(operator == 'x'){
                  operator = '*';
                }
                else if(operator == '÷'){
                  operator = '/';
                }
                setState(() {
                  _result = calVat(double.tryParse(num1.text) ?? 0,operator, double.tryParse(num2.text) ?? 0);
                });
                history.insert(0,"Cal VAT: ${_result}");
              },
              child: const Text('Cal VAT', style: TextStyle(fontSize: 28)),
            ),
          ],
        ),
      ],
    );

    // 3. แยกส่วน History Content ออกมาเก็บไว้เป็นตัวแปร
    Widget historyContent = Column(
      children: [
        const Text('History', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Expanded(
          child: ListView(
            children: [
              for (String item in history)
                ListTile(
                  title: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('เครื่องคิดเลขแบบง่าย'),
        leadingWidth: 200, // เพิ่มความกว้างของพื้นที่ leading เล็กน้อยเพื่อให้แสดงข้อความ "About us" ได้พอดี
        leading: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutPage()),
            );
          },
          child: const Text(
            'About us',
            style: TextStyle(
              color: Color.fromARGB(255, 106, 0, 78), // กำหนดสีตัวหนังสือให้ตัดกับ AppBar
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: isLandscape
            ? Row(
                // ถ้าหมุนเป็นแนวนอน: แบ่งครึ่งซ้าย-ขวา
                children: [
                  Expanded(child: calculatorContent),
                  const VerticalDivider(thickness: 2), // เส้นคั่นกลาง
                  Expanded(child: historyContent),
                ],
              )
            : Column(
                // ถ้าเป็นแนวตั้งปกติ: เรียงบน-ล่าง
                children: [
                  calculatorContent,
                  const SizedBox(height: 20),
                  Expanded(child: historyContent),
                ],
              ),
      ),
    );
  }
}