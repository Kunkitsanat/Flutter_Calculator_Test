import 'package:flutter/material.dart';

  String checkOddEven(double num1 , double num2 , double num3){
    int odd = 0;
    int even = 0;
    List <double> nums = [num1,num2,num3];
    for (double num in nums){
      if(num % 2 == 0){
        even += 1;
      }
      else{
        odd += 1;
      }
    }

    if(even > odd){
      return "EVEN";
    }
    else{
      return "ODD";
    }
  }

class OddEven extends StatefulWidget {
  const OddEven({super.key});

  @override
  State<OddEven> createState() => _OddEvenState();
}

class _OddEvenState extends State<OddEven> {
  final TextEditingController num1 = TextEditingController();
  final TextEditingController num2 = TextEditingController();
  final TextEditingController num3 = TextEditingController();
  String result = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('OddEven_Appbar'),
        title: const Text('OddEven'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

                const SizedBox(width: 10),

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

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    controller: num3,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'ตัวเลข 3',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25)
                    ),
                  ),
                ),
                ],
               ),

               const SizedBox(height: 20,),

                // Buttton Process
                ElevatedButton(onPressed: (){
                  setState(() {
                    result = checkOddEven(double.tryParse(num1.text) ?? 0,double.tryParse(num2.text) ?? 0,double.tryParse(num3.text) ?? 0);
                  });
                }, child: const Text('Processs',style: TextStyle(fontSize: 24),)),

                const SizedBox(height: 20,),
                
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    key: const Key('Odd/Even_text'),
                    result.isEmpty ? "0" : result,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  )))
            ],
            )
          );
  }
}