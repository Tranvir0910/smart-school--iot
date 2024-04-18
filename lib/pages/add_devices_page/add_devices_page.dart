import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/add_devices_page/widgets/custom_scaffold.dart';
import 'package:flutter_svg/svg.dart';
import '../../const/const.dart';

class AddDevices extends StatefulWidget {
  const AddDevices({super.key});

  @override
  State<AddDevices> createState() => _AddDevicesState();
}

class _AddDevicesState extends State<AddDevices> {

  final _formAddKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    Constants myConstants = Constants();

    final List<String> classRoom = [
      '2A08',
      '2A16',
      '2A27',
      '2A34',
    ];

    final List<Map<String, String>> svgIcons = [
      {'name': 'Fan', 'path': 'assets/svg/fan.svg'},
      {'name': 'Projector', 'path': 'assets/svg/projector.svg'},
      {'name': 'Board', 'path': 'assets/svg/smart_board.svg'},
      {'name': 'Bright', 'path': 'assets/svg/bright.svg'},
      {'name': 'Clock', 'path': 'assets/svg/clock.svg'},
      {'name': 'Drop', 'path': 'assets/svg/drop.svg'},
      {'name': 'Light', 'path': 'assets/svg/light.svg'},
      {'name': 'Snow', 'path': 'assets/svg/snow.svg'},
      {'name': 'TV', 'path': 'assets/svg/tv.svg'},
      {'name': 'Speaker', 'path': 'assets/svg/speaker.svg'},
    ];

    final List<String> devicesType = [
      'Fan',
      'Led',
      'Smart Board',
      'Projector',
      'Computer',
      'Tablet',
      'Smartphone',
      'Document Camera',
      'Audio System',
      'Visualizer',
    ];


  String devicesName = '';
  String selectedClassroom = '';
  String selectedIconPath = '';
  String typeDevices = '';
  String color = '';

    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                // get started form
                child: Form(
                  key: _formAddKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => FocusScope.of(context).requestFocus(_nameController as FocusNode?),
                      child: 
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Devices Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(16),
                          label: const Text('Devices Name'),
                          labelStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          hintText: 'Enter Devices Name',
                          hintStyle: const TextStyle(
                            color: Colors.black45,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black45, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black45, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),

                        onChanged: (value) {
                          devicesName = value.toString();
                        },
                        onSaved: (newValue) => devicesName = newValue.toString(),
                      ),),
                      const SizedBox(
                        height: 25.0,
                      ),
                      DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                          // the menu padding when button's width is not specified.
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // Add more decoration..
                        ),
                        hint: const Text(
                          'Select Your Classroom',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: classRoom
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Classroom.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          selectedClassroom = value.toString();
                        },
                        onSaved: (value) {
                          
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                          // the menu padding when button's width is not specified.
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // Add more decoration..
                        ),
                        hint: const Text(
                          'Select Your Type Devices',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: devicesType
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select Type Devices.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          typeDevices = value.toString();
                        },
                        onSaved: (value) {
                          
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),

                      // TextButton(
                      //   onPressed: () {
                      //     if (_formKey.currentState!.validate()) {
                      //       _formKey.currentState!.save();
                      //     }
                      //   },
                      //   child: const Text('Submit Button'),
                      // ),

                      const SizedBox(
                        height: 25.0,
                      ),

                      DropdownButtonFormField2<Map<String, String>>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          // Add Horizontal padding using menuItemStyleData.padding so it matches
                          // the menu padding when button's width is not specified.
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // Add more decoration..
                        ),
                        hint: const Text(
                          'Select Your Icon',
                          style: TextStyle(fontSize: 14),
                        ),
                        items: svgIcons.map((icon) {
                          return DropdownMenuItem<Map<String, String>>(
                            value: icon,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  icon['path'] ?? '',
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  icon['name'] ?? '',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),

                        validator: (value) {
                          if (value == null) {
                            return 'Please select Icon.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          selectedIconPath = value!['path'] ?? '';
                        },
                        onSaved: (value) {
                          
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            backgroundColor: myConstants.primaryColor,
                            padding: const EdgeInsets.all(15),
                            textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      )
                          ),
                          onPressed: () async {
                            if (_formAddKey.currentState!.validate()) {
                              
                              CollectionReference<Map<String, dynamic>> collectionRef = FirebaseFirestore.instance.collection('Devices');

                              collectionRef.doc(selectedClassroom).get()
                                .then((docSnapshot) {
                                  if(typeDevices == 'Fan'){
                                    color = '#cee7f0';
                                  }else if(typeDevices == 'Led'){
                                    color = '#fef7e2';
                                  }else{
                                    color = '#9fe3ee';
                                  }
                                  if (docSnapshot.data()!.containsKey(devicesName)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Device name "$devicesName" already exists. Please choose a different name.'),
                                      ),
                                    );
                                  } else {
                                    Map<String, dynamic> updateData = {
                                      devicesName : {
                                        "devicesName": devicesName,
                                        "classRoom": selectedClassroom,
                                        "iconPath": selectedIconPath,
                                        "typeDevices": typeDevices,
                                        "isActive": false,
                                        "color": color,
                                      }
                                    };

                                    print('Update Data: $updateData');

                                    collectionRef.doc(selectedClassroom).set(updateData, SetOptions(merge: true))
                                      .then((_) {
                                        print('Document added with custom ID: $selectedClassroom');
                                      })
                                      .catchError((error) {
                                        print('Failed to add document: $error');
                                      });
                                  }
                                })
                                .catchError((error) {
                                  print('Error checking document existence: $error');
                                });
                            } 
                          },
                          child: const Text('Add Devices', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
