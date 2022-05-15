import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function submitName;

  SearchBarWidget(this.submitName);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: SizedBox(
        height: 50,
        child: TextField(
          autofocus: true,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              hintText: 'search here',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
            controller: _titleController,
            onSubmitted: (text) => widget.submitName(text)),
      ),
    );
  }
}
