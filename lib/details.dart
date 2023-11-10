import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List<String> contactNumbers = List.filled(3, '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Emergency Contacts',
            style: TextStyle(
              color: Color(0xFF907F9F),
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFF907F9F),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Enter your closest loved ones details',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PhoneNumberInputField(
                label: 'Contact ${i + 1}',
                onSave: (value) {
                  setState(() {
                    contactNumbers[i] = value;
                  });
                },
              ),
            ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // Navigate to the page to enter contact numbers of neighbors
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NeighborsPage(
                    onSave: (value) {
                      // Save neighbor contact numbers
                      // This could be similar to how contactNumbers are saved
                    },
                  ),
                ),
              );
            },
            child: Text(
              'Next',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF907F9F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneNumberInputField extends StatefulWidget {
  final String label;
  final Function(String) onSave;

  const PhoneNumberInputField({
    Key? key,
    required this.label,
    required this.onSave,
  }) : super(key: key);

  @override
  _PhoneNumberInputFieldState createState() => _PhoneNumberInputFieldState();
}

class _PhoneNumberInputFieldState extends State<PhoneNumberInputField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      onChanged: (value) {
        widget.onSave(value);
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}

class NeighborsPage extends StatefulWidget {
  final Function(List<String>) onSave;

  const NeighborsPage({Key? key, required this.onSave}) : super(key: key);

  @override
  _NeighborsPageState createState() => _NeighborsPageState();
}

class _NeighborsPageState extends State<NeighborsPage> {
  List<TextEditingController> neighborControllers =
  List.generate(3, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Neighbor Contacts',
          style: TextStyle(
            color: Color(0xFF907F9F),
          ),
        ),
      ),
      backgroundColor: Color(0xFF907F9F),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Enter contact numbers of neighbors',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < neighborControllers.length; i++)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: neighborControllers[i],
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: 'Neighbor ${i + 1}',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // Save neighbor contact numbers
              List<String> neighborNumbers = [];
              for (var controller in neighborControllers) {
                neighborNumbers.add(controller.text);
              }
              widget.onSave(neighborNumbers);

              // Navigate to the page to display saved numbers
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayNumbersPage(
                    contactNumbers: [],
                    neighborNumbers: neighborNumbers,
                  ),
                ),
              );
            },
            child: Text(
              'Next',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF907F9F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class DisplayNumbersPage extends StatelessWidget {
  final List<String> contactNumbers;
  final List<String> neighborNumbers;

  DisplayNumbersPage({
    required this.contactNumbers,
    required this.neighborNumbers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Contacts',
          style: TextStyle(
            color: Color(0xFF907F9F),
          ),
        ),
      ),
      backgroundColor: Color(0xFF907F9F),
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Display the saved numbers here',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          for (int i = 0; i < contactNumbers.length; i++)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Contact ${i + 1}: ${contactNumbers[i]}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          for (int i = 0; i < neighborNumbers.length; i++)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Neighbor ${i + 1}: ${neighborNumbers[i]}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
