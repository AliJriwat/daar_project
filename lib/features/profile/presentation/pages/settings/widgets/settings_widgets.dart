import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCurrencyPicker(BuildContext context, List<String> currencies, Function(String) onSelected ) {
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text("seleziona valuta"),
        actions: currencies.map((currency) {
          return CupertinoActionSheetAction(
            child: Text(currency),
            onPressed: () {
              Navigator.pop(context);
              onSelected(currency); // restituisce la scelta
            },
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text("Chiudi"),
        ),
      ),
  );
}
Widget buildSettingsOption({
  required BuildContext context,
  required String text,
  required String trailingText,
  required VoidCallback onTap,
}) {
  return ListTile(
    onTap: onTap,
    title: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min, // importante per farlo stare a destra
      children: [
          Text(
            trailingText,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        SizedBox(width: 8), // spazio tra testo e freccia
        Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
      ],
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
  );
}
/*
child: CupertinoButton(
          color: Colors.blue,
          child: Text("Apri Action Sheet"),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) => CupertinoActionSheet(
                title: Text("Seleziona un'opzione"),
                message: Text("Scorri per vedere tutte le azioni"),
                actions: List.generate(20, (index) {
                  // Creiamo 20 azioni per esempio
                  return CupertinoActionSheetAction(
                    child: Text("Opzione ${index + 1}"),
                    onPressed: () {
                      Navigator.pop(context);
                      print("Hai selezionato Opzione ${index + 1}");
                    },
                  );
                }),
                cancelButton: CupertinoActionSheetAction(
                  child: Text("Chiudi"),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        ),
 */