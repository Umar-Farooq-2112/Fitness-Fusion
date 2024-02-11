import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class calendar extends StatefulWidget {
  const calendar({Key? key}) : super(key: key);

  @override
  _calendarState createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  // Map to store tasks for each day
  final Map<DateTime, List<String>> _events = {
    DateTime(2023, 12, 1): ['Task 1', 'Task 2'],
    DateTime(2023, 12, 5): ['Task 3'],
    // Add more entries as needed
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
              color: Colors.orange,
            )),
          ),
          // Display the todo list for the selected day
          Expanded(
            child: ListView(
              children: _events[_selectedDay]?.map((task) {
                    return ListTile(
                      title: Text(task),
                    );
                  }).toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }
}
