import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/helper_widgets/scroll_list_widget.dart';
import 'package:app04/screens/helper_widgets/searchfield_widget.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../models/search_filter_model.dart';
import '../../utilities/consts.dart';
import 'filter_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchName = '';
  SearchFilter searchFilter = constSearchFilter;
  bool refresh = true;

  void submitFilter(SearchFilter filter) =>
      setState(() => searchFilter = filter);

  Future<void> submitName(String name) async {
    setState(() {
      refresh = true;
    });
    await Future.delayed(const Duration(milliseconds: 50));

    setState(() {
      refresh = false;
      searchName = name;
    });
  }

  Future<List<LowDataItem>?> search(int page) {
    var response = getSearchItems(searchName, page, searchFilter.toString());
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 20),
                SearchFieldWidget(submitName),
                IconButton(
                  onPressed: () async {
                    _bottomSheet(context);
                  },
                  icon: const Icon(
                    Icons.filter_alt,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            (!refresh)?
              searchList(searchName): const SizedBox(width: 1,)
          ]
        ),
      ),
    );
  }
  _bottomSheet(ctx){
    showModalBottomSheet(
        context: ctx,
        backgroundColor: color5,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),

        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 0, 2),
            child: FilterWidget(submitFilter),
          );
        });
  }
  Widget searchList(String name)=> Expanded(child: ScrollListWidget(search));
}
