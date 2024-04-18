import 'package:flutter/material.dart';
import '../../../const/const.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    Constants myConstants = Constants();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: myConstants.primaryColor,
        centerTitle: true,
        title: const Text(
          'Add Devices',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w900
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SafeArea(
            child: child!,
          ),
        ],
      ),
    );
  }
}
