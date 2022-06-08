import 'package:app04/utilities/consts.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  final Function submitName;

  SearchFieldWidget(this.submitName);

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  bool isSearchEmpty = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 6, 0, 5),
          decoration: BoxDecoration(
              color: color1,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 1.0,
                ),
                BoxShadow(
                  offset: Offset(0, -1),
                  blurRadius: 1.0,
                )
              ]),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              suffixIcon: (!isSearchEmpty)
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _searchController.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() => isSearchEmpty = true);
                      },
                    )
                  : const SizedBox(width: 0.1),
              icon: SizedBox(
                width: 25,
                child: IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    widget.submitName(_searchController.text);
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
              border: InputBorder.none,
              hintText: "Search ...",
            ),
            onChanged: (newText) {
              if (newText.isNotEmpty && isSearchEmpty) {
                setState(() {
                  isSearchEmpty = false;
                });
              } else if (newText.isEmpty && !isSearchEmpty) {
                setState(() {
                  isSearchEmpty = true;
                });
              }
            },
            onSubmitted: (text) => widget.submitName(text),
          ),
        ),
      ),
    );
  }
}
