import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Devices extends StatelessWidget {
  final String name;
  final String svg;
  final Color color;
  final bool isActive;
  final Function(bool) onChanged;

  const Devices(
      {Key? key,
      required this.name,
      required this.svg,
      required this.color,
      required this.onChanged,
      required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OpenContainer(
          transitionType: ContainerTransitionType.fadeThrough,
          transitionDuration: const Duration(milliseconds: 600),
          closedElevation: 0,
          openElevation: 0,
          openShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          openBuilder: (BuildContext context, VoidCallback _) {
            return const Text('');
          },
          tappable: name == "Smart AC" ? true : false,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(20.0),
                ),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 0.6,
                ),
                color: isActive ? color : Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          svg,
                          // ignore: deprecated_member_use
                          color: Colors.black,
                          height: 30,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            name,
                            style: const TextStyle(
                                height: 1.2,
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    // Transform.scale(
                    //   alignment: Alignment.center,
                    //   scaleY: 0.8,
                    //   scaleX: 0.85,
                    //   child: CupertinoSwitch(
                    //     onChanged: onChanged,
                    //     value: isActive,
                    //     activeColor: isActive
                    //         ? Colors.white.withOpacity(0.4)
                    //         : Colors.black,
                    //     trackColor: Colors.black,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'OFF',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: !isActive
                                      ? const Color.fromARGB(255, 0, 0, 0)
                                      : Colors.black.withOpacity(0.3),
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '/',
                                    style:
                                        TextStyle(color: Colors.black.withOpacity(0.3))),
                                TextSpan(
                                  text: 'ON',
                                  style: TextStyle(
                                    color: isActive
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                        : Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ]),
                        ),
                        Transform.scale(
                          alignment: Alignment.center,
                          scaleY: 0.8,
                          scaleX: 0.85,
                          child: CupertinoSwitch(
                            onChanged: onChanged,
                            value: isActive,
                            activeColor: Colors.white.withOpacity(0.5),
                            trackColor: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
