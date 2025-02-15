import 'package:firebase_operations/services/time_calculator.dart';
import 'package:firebase_operations/views/add_club_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddClubView extends StatefulWidget {
  const AddClubView({super.key});

  @override
  State<AddClubView> createState() => _AddClubViewState();
}

class _AddClubViewState extends State<AddClubView> {
  TextEditingController clubNameController = TextEditingController();
  TextEditingController clubCoachController = TextEditingController();
  TextEditingController foundedDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var selectedDate;

  @override
  void dispose() {
    clubNameController.dispose();
    clubCoachController.dispose();
    foundedDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddClubViewModel>(
      create: (_) => AddClubViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'ADD CLUB',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: clubNameController,
                  decoration: InputDecoration(
                    hintText: 'Club name',
                    icon: Icon(
                      Icons.sports_soccer,
                    ),
                  ),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Club name can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: clubCoachController,
                  decoration: InputDecoration(
                    hintText: 'Club coach',
                    icon: Icon(
                      Icons.people_alt,
                    ),
                  ),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Club coach can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  onTap: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1863),
                      initialDate: DateTime.now(),
                      lastDate: DateTime.now(),
                    );
                    foundedDateController.text =
                        TimeCalculator.dateTimeToString(selectedDate);
                  },
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  controller: foundedDateController,
                  decoration: InputDecoration(
                    hintText: 'Club founded date',
                    icon: Icon(
                      Icons.date_range,
                    ),
                  ),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Founded date can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await Provider.of<AddClubViewModel>(context,
                              listen: false)
                          .addClub(
                              clubName: clubNameController.text,
                              clubCoach: clubCoachController.text,
                              foundedDate: selectedDate);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ADD CLUB',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
