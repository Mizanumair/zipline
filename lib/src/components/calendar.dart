import 'package:courier_app/src/features/features/all_item/all_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    null,
    null,
  ];
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  AllItemController allItemsController = Get.put(AllItemController());

  @override
  Widget build(BuildContext context) {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.teal[800],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );

    return AlertDialog(
      title: Center(child: Text('Set Date Range')),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 100, // Adjust the width as needed
                  height: 50,
                  // Adjust the height as needed
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: Offset(0, 3), // Offset in the x and y direction
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(_selectedStartDate != null ? DateFormat('yMd').format(_selectedStartDate!) : 'Start',
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16, // Adjust font size as needed
                        )),
                  ),
                ),
                Container(
                  width: 100, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    color: _selectedStartDate != null ? Colors.orange : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: Offset(0, 3), // Offset in the x and y direction
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _selectedEndDate != null ? DateFormat('yMd').format(_selectedEndDate!) : 'End',
                      style: TextStyle(
                        color: _selectedEndDate != null ? Colors.white : Colors.black, // Text color
                        fontSize: 16, // Adjust font size as needed
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                CalendarDatePicker2(
                  config: config,
                  value: _rangeDatePickerValueWithDefaultValue,
                  onValueChanged: (dates) {
                    setState(
                      () {
                        _rangeDatePickerValueWithDefaultValue = dates;
                        _selectedStartDate = dates[
                            0]; //_rangeDatePickerValueWithDefaultValue[0] != null ? _rangeDatePickerValueWithDefaultValue[0] : null;
                        _selectedEndDate = dates[
                            1]; //_rangeDatePickerValueWithDefaultValue[1] != null ? _rangeDatePickerValueWithDefaultValue[1] : null;
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  final dateStart =
                      _getValueText(CalendarDatePicker2Type.range, [_selectedStartDate, _selectedEndDate], true);
                  final dateEnd =
                      _getValueText(CalendarDatePicker2Type.range, [_selectedStartDate, _selectedEndDate], false);
                  allItemsController.setSelectedDate = '${dateStart.trim()}:${dateEnd.trim()}';
                  Navigator.of(context).pop();
                  _selectedStartDate = null;
                  _selectedEndDate = null;
                  print(dateStart);
                  print(dateEnd);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white)),
                ),
                child: Text('Apply'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                child: Text('Cancel'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
    bool start,
  ) {
    values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null).toString().replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.range && start == true) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        // final endDate = values.length > 1
        //     ? values[1].toString().replaceAll('00:00:00.000', '')
        //     : 'null';
        valueText = startDate;
      } else {
        return 'null';
      }
    } else {
      if (values.isNotEmpty) {
        // final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1 ? values[1].toString().replaceAll('00:00:00.000', '') : 'null';
        valueText = endDate;
      } else {
        return 'null';
      }
    }
    print(valueText);
    return valueText;
  }

// Function to send GET request
//   void _sendGetRequest() async {
//     List<DateTime?> mainList = [_selectedStartDate, _selectedEndDate];
//
//     try {
//       final response = await http.get(Uri.parse('your_api_endpoint_here'));
//       if (response.statusCode == 200) {
//         // Request was successful, handle the response data
//         print('GET request successful');
//         print('Response data: ${response.body}');
//       } else {
//         // Request failed, handle the error
//         print('GET request failed with status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       // Handle any exceptions or errors
//       print('Error sending GET request: $error');
//     }
//   }
}
