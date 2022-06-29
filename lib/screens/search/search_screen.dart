import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/helper_widgets/scroll_list_widget.dart';
import 'package:app04/screens/helper_widgets/searchfield_widget.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../models/properties_model.dart';
import '../../models/search_filter_model.dart';
import '../../utilities/consts.dart';
import '../staff/staff_list_widget.dart';
import 'filter_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';
  SearchFilter searchFilter = constSearchFilter;

   SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchName = '';
  bool refresh = true;

  void submitFilter(SearchFilter filter) =>
      setState(() => widget.searchFilter = filter);

  void submitFilterType(FilterType type) =>
      setState(() => widget.searchFilter.filterType = type);


  Future<void> submitName(String name) async {
    setState(() => refresh = true);
    await Future.delayed(const Duration(milliseconds: 50));
    setState(() {
      refresh = false;
      searchName = name;
    });
  }

  Future<List<LowDataItem>?> searchFilm(int page) =>
      getSearchItems(searchName, page, widget.searchFilter.filmToString());

  Future<List<Staff>?> searchStaff(int page) => getStaffSearchItems(searchName, page, widget.searchFilter.staffToString(), false);

  Future<List<Staff>?> searchCharacter(int page) =>
      getStaffSearchItems(searchName, page, widget.searchFilter.staffToString(), true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 5),
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
          ],
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          (!refresh)
              ? ((FilterType.film == widget.searchFilter.filterType)
                  ? Expanded(child: ScrollListWidget(searchFilm))
                  : (FilterType.staff == widget.searchFilter.filterType)
                      ? Expanded(child: StaffScrollListWidget(searchStaff, true),)
                      : Expanded(
                          child: StaffScrollListWidget(searchCharacter, false),
                        ))
              : const SizedBox(width: 1)
        ]),
      ),
    );
  }

  _bottomSheet(ctx) {
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
            child: FilterWidget(submitFilter, widget.searchFilter.filterType),
          );
        });
  }
}
