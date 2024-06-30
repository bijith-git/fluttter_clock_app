import 'package:clock_app/features/widget/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlramScreen extends StatefulWidget {
  const AlramScreen({super.key});

  @override
  State<AlramScreen> createState() => _AlramScreenState();
}

class _AlramScreenState extends State<AlramScreen> {
  ExpansionPanel buildExpansionPanelList(bool isOpen) {
    return ExpansionPanel(
        isExpanded: isOpen,
        headerBuilder: (_, isOpen) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconedText(
                iconData: Icons.label_outline,
                text: "Work",
              ),
              const SizedBox(height: 10),
              Text(
                DateFormat("hh:mm a").format(DateTime.now()),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 25),
              ),
              const Text("Not Scheduled"),
            ],
          );
        },
        body: const Column(
          children: [
            IconedText(iconData: Icons.alarm, text: "Pause Alarm"),
            IconedText(
                iconData: Icons.notifications_on_outlined, text: "Default  "),
            IconedText(iconData: Icons.vibration, text: "Vibrate"),
            IconedText(iconData: Icons.delete, text: "Delete"),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text(
          'Alram',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: ExpansionPanelList(
          expansionCallback: (index, isOpne) {
            isOpne = !isOpne;
            setState(() {});
          },
          children: List.generate(2, (i) {
            bool isExpanded = false;
            return buildExpansionPanelList(isExpanded);
          }),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
