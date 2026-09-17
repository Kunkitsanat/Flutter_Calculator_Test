import 'package:flutter/material.dart';
import 'package:simple_calc/calculate.dart';
import 'about_page.dart';
import 'odd_even.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 253, 84, 0),
        ),
      ),
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

  List<String> history = [];

  void clearHistory() {
    setState(() {
      history.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget calculatorContent = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OddEven()),
              );
            },
            child: const Text('OddEven', style: TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 12),

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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  ),
                ),
              ),

              const SizedBox(width: 4),

              // ช่องแสดงเครื่องหมาย
              SizedBox(
                width: 24,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    operator,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(width: 4),

              // ช่องกรอกตัวที่ 2
              Expanded(
                child: TextField(
                  controller: num2,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'ตัวเลข 2',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  ),
                ),
              ),

              const SizedBox(width: 4),

              const SizedBox(
                width: 16,
                child: Center(
                  child: Text('=', style: TextStyle(fontSize: 20)),
                ),
              ),

              const SizedBox(width: 4),

              // ช่องแสดงผล
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _result.isEmpty ? "0" : _result,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ปุ่มคำนวณและปุ่มเคลียร์ (เปลี่ยนเป็น Wrap เพื่อไม่ให้ปุ่มดันกันจนล้นจอ)
          Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result = calculate(
                      double.tryParse(num1.text) ?? 0,
                      '+',
                      double.tryParse(num2.text) ?? 0,
                    );
                    history.insert(0, "${num1.text} + ${num2.text} = $_result");
                    operator = '+';
                  });
                },
                child: const Text('+', style: TextStyle(fontSize: 22)),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result = calculate(
                      double.tryParse(num1.text) ?? 0,
                      '-',
                      double.tryParse(num2.text) ?? 0,
                    );
                    history.insert(0, "${num1.text} - ${num2.text} = $_result");
                    operator = '-';
                  });
                },
                child: const Text('-', style: TextStyle(fontSize: 22)),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result = calculate(
                      double.tryParse(num1.text) ?? 0,
                      '*',
                      double.tryParse(num2.text) ?? 0,
                    );
                    history.insert(0, "${num1.text} x ${num2.text} = $_result");
                    operator = 'x';
                  });
                },
                child: const Text('×', style: TextStyle(fontSize: 22)),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result = calculate(
                      double.tryParse(num1.text) ?? 0,
                      '/',
                      double.tryParse(num2.text) ?? 0,
                    );
                    history.insert(0, "${num1.text} ÷ ${num2.text} = $_result");
                    operator = '÷';
                  });
                },
                child: const Text('÷', style: TextStyle(fontSize: 22)),
              ),
              ElevatedButton(
                onPressed: clearHistory,
                child: const Text('C', style: TextStyle(fontSize: 22)),
              ),
              ElevatedButton(
                onPressed: () {
                  if (operator == 'x') {
                    operator = '*';
                  } else if (operator == '÷') {
                    operator = '/';
                  }
                  setState(() {
                    _result = calVat(
                      double.tryParse(num1.text) ?? 0,
                      operator,
                      double.tryParse(num2.text) ?? 0,
                    );
                  });
                  history.insert(0, "Cal VAT: $_result");
                },
                child: const Text('Cal VAT', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    );

    // ส่วน History Content
    Widget historyContent = Column(
      children: [
        const Text(
          'History',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView(
            children: [
              for (String item in history)
                ListTile(
                  dense: true,
                  title: Text(
                    item,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'เครื่องคิดเลขแบบง่าย',
          style: TextStyle(fontSize: 18),
        ),
        leadingWidth: 100,
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
              color: Color.fromARGB(255, 106, 0, 78),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isLandscape
            ? Row(
                children: [
                  Expanded(child: calculatorContent),
                  const VerticalDivider(thickness: 2),
                  Expanded(child: historyContent),
                ],
              )
            : Column(
                children: [
                  calculatorContent,
                  const SizedBox(height: 12),
                  Expanded(child: historyContent),
                ],
              ),
      ),
    );
  }
}