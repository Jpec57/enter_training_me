import 'package:flutter/material.dart';
import 'package:flag/flag.dart';

class FlagIcon extends StatelessWidget {
  final String? countryCode;
  const FlagIcon({Key? key, this.countryCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 40,
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Flag.fromString(
        countryCode != null ? countryCode!.toLowerCase() : '',
        fit: BoxFit.fill,
        replacement: const Icon(Icons.not_listed_location_outlined),
      ),
    );
  }
}
