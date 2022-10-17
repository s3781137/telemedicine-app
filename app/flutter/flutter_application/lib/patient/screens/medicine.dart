import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/patient/model/patient_booking_model.dart';

import '../core/api_patient.dart';
import '../model/patient_medicine_model.dart';
import '../patient.dart';
import '../widgets/appbar.dart';

class ViewMedicineScreen extends StatefulWidget {
  const ViewMedicineScreen({Key? key}) : super(key: key);

  @override
  State<ViewMedicineScreen> createState() => _ViewMedicineScreenState();
}

class _ViewMedicineScreenState extends State<ViewMedicineScreen> {
  final ApiClient _apiClient = ApiClient();
  int? id = -1;
  List<PatientMedicineModel> _medicines = [];
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    List<PatientMedicineModel> medicines = await _apiClient.fetchMedicines(
        currentLoggedInUser["username"]
            .toString()); // load the availabilities on Widget init
    setState(() => _medicines = medicines);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context),
      body: ListView.separated(
        itemCount: _medicines.length,
        itemBuilder: (BuildContext ctxt, int i) {
          return GestureDetector(
            // todo on tap
            onTap: () => {},
            child: Column(
              children: [
                Text(
                  "Doctor: ${_medicines[i].doctorUsername} ",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Date and Time: ${_medicines[i].medicine}",
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
