import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../const/const.dart';
import '../pages/home/control_page.dart';
class DropDownSelect extends StatefulWidget {
  const DropDownSelect({super.key});

  @override
  State<DropDownSelect> createState() => _DropDownSelectState();
}

class _DropDownSelectState extends State<DropDownSelect> {
  final List<String> items = [
  '2A08',
  '2A16',
  '2A27',
  '2A34',
];
String? selectedValue;

@override
Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    Constants myConstants = Constants();

    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            customButton: Container(
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: myConstants.primaryColor, // Màu viền
                  width: 1, // Độ dày của viền
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.list,
                    size: 40,
                    color: myConstants.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      selectedValue ?? 'Select Classroom',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: myConstants.primaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    size: 40,
                    color: myConstants.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
                Map<String, dynamic> updateData = {
                  "status classroom check": {
                    "2A08": false,
                    "2A16": false,
                    "2A27": false,
                    "2A34": false,
                    // Thêm các trạng thái khác nếu cần
                  },
                };
                if (value == '2A08') {
                  updateData["status classroom check"]["2A08"] = true;
                } else if (value == '2A16') {
                  updateData["status classroom check"]["2A16"] = true;
                } else if (value == '2A27') {
                  updateData["status classroom check"]["2A27"] = true;
                } else if (value == '2A34') {
                  updateData["status classroom check"]["2A34"] = true;
                }
                ref.update(updateData);
                MenuItems.onChanged(context, value!);
              });
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 140,
            ),
            dropdownStyleData: DropdownStyleData(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: myConstants.primaryColor,
              ),
              offset: const Offset(0, 8),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
  });

  final String text;
}

abstract class MenuItems {
  static void onChanged(BuildContext context, String item) {
    switch (item) {
      case '2A08':
        break;
      case '2A16':
        //Do something
        break;
      case '2A27':
        //Do something
        break;
      case '2A34':
        //Do something
        break;
    }
  }
}