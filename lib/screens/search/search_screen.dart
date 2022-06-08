import 'package:app04/models/low_data_item.dart';
import 'package:app04/screens/search/searchfield_widget.dart';
import 'package:app04/utilities/http_helper.dart';
import 'package:flutter/material.dart';
import '../../models/search_filter_model.dart';
import '../../utilities/consts.dart';
import '../helper_widgets/scroll_list_widget.dart';
import '../helper_widgets/vertical_shimmer.dart';
import 'filter_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchName = '';
  bool refresh = false;
  SearchFilter searchFilter = SearchFilter();

  void submitFilter(SearchFilter filter) =>
      setState(() => searchFilter = filter);

  void submitName(String name) {
    setState(() {
      searchName = name;
      refresh = true;
    });
    Future.delayed(const Duration(milliseconds: 100), () => setState(() => refresh = false));
  }

  Future<List<LowDataItem>?> search(int page) {
    return getSearchItems(searchName, page, searchFilter.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  SearchFieldWidget(submitName),
                  IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          useSafeArea: false,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: SizedBox(
                                  width: screenWidth,
                                  height: 420,
                                  child: FilterWidget(submitFilter),
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.filter_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
              (searchName != "")
                  ? SizedBox(
                      width: screenWidth,
                      height: screenHeight - 55,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: (refresh == false)
                            ? ScrollListWidget(search)
                            : const SizedBox(height: 0.1),
                      ),
                    )
                  : const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('nothing to show'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
