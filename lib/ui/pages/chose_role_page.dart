import 'package:flutter/material.dart';
import 'package:project_manager/ui/pages/register_page.dart';

class ChoseRolePage extends StatefulWidget {
  const ChoseRolePage({Key? key}) : super(key: key);

  @override
  State<ChoseRolePage> createState() => _ChoseRolePageState();
}

class _ChoseRolePageState extends State<ChoseRolePage> {
  String _role = 'manager';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: EdgeInsets.only(top: 50, bottom: 24, left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Seleect your role',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: _role,
                    onChanged: (String? value) {
                      setState(() {
                        _role = value!;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: 'manager',
                        child: Text('Manager'),
                      ),
                      DropdownMenuItem(
                        value: 'employee',
                        child: Text('Employee'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  _role == 'manager'
                      ? "Managers can make projects and add employees to their projects. His task is to manage all of the employee's tasks, and make sure the project is finished right on time."
                      : "The employee's task is to finish the task that the manager gave him. He can change the status of the task to 'done', and if the manager returns the task the status becomes 'pending'.",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterPage(role: _role),
                    ),
                  );
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
