import 'package:app04/models/staff_seach_filter_model.dart';
import 'package:app04/screens/helper_widgets/searchfield_widget.dart';
import 'package:app04/screens/staff/staff_filter.dart';
import 'package:app04/screens/staff/staff_list_widget.dart';
import 'package:flutter/material.dart';
import '../../models/properties_model.dart';
import '../../utilities/consts.dart';
import '../../utilities/http_helper.dart';
import '../helper_widgets/scroll_list_widget.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({Key? key}) : super(key: key);
  static const routeName = '/start-screen';

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  String searchName = '';
  StaffSearchFilter searchFilter = StaffSearchFilter(false);
  bool refresh = true;

  void submitFilter(StaffSearchFilter filter) =>
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

  Future<List<Staff>?> getStaff(int page) => getStaffSearchItems(searchName, page, searchFilter.toString(), searchFilter.isCharacter);

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
                  SizedBox(width: 20,),
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
                  SizedBox(width: 10,),

                ],
              ),
              (!refresh)?
              searchList(searchName): const SizedBox(width: 1,)
            ]
        ),
      ),
    );
  }
 void _bottomSheet(ctx){
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
            child: StaffFilterWidget(submitFilter),
          );
        });
  }

  Widget searchList(String name)=> Expanded(child: StaffScrollListWidget(getStaff));
}
