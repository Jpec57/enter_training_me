import 'package:enter_training_me/widgets/flag_icon.dart';
import 'package:flutter/material.dart';

typedef LocaleVoidCallback = void Function(Locale locale);

class ChangeLanguageDialog extends StatelessWidget {
  final List<Locale> supportedLocales;
  final Locale? currentLocale;
  final LocaleVoidCallback onLocaleChosen;

  const ChangeLanguageDialog(
      {Key? key,
      required this.supportedLocales,
      this.currentLocale,
      required this.onLocaleChosen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Change goal language",
              style: Theme.of(context).textTheme.headline3,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: supportedLocales.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    onLocaleChosen(supportedLocales[i]);
                    Navigator.of(context).pop();
                  },
                  leading:
                      FlagIcon(countryCode: supportedLocales[i].countryCode),
                  title: Text(
                    supportedLocales[i].languageCode.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
