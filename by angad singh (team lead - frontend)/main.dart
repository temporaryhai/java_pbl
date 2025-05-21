import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';

void main() {
  runApp(SmartCommuteApp());
}

class SmartCommuteApp extends StatefulWidget {
  @override
  _SmartCommuteAppState createState() => _SmartCommuteAppState();
}

class _SmartCommuteAppState extends State<SmartCommuteApp> {
  // Theme mode notifier
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.light);

  @override
  void dispose() {
    _themeMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Smart Commute',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
            fontFamily: 'Segoe UI',
            scaffoldBackgroundColor: Colors.indigo.shade50,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            fontFamily: 'Segoe UI',
            scaffoldBackgroundColor: Colors.grey.shade900,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.deepPurple.shade700,
              foregroundColor: Colors.white,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent.shade700,
              ),
            ),
          ),
          home: SplashScreen(
            onThemeChanged: (newMode) {
              _themeMode.value = newMode;
            },
            currentThemeMode: mode,
          ),
        );
      },
    );
  }
}

// Splash Screen with theme toggle callback (optional)
class SplashScreen extends StatefulWidget {
  final Function(ThemeMode)? onThemeChanged;
  final ThemeMode? currentThemeMode;

  SplashScreen({this.onThemeChanged, this.currentThemeMode});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => HomeScreen(
                onThemeChanged: widget.onThemeChanged,
                currentThemeMode: widget.currentThemeMode,
              )));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade100,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Text(
            'Smart Commute',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
      ),
    );
  }
}

// Home Screen with Dark Mode Toggle
class HomeScreen extends StatefulWidget {
  final Function(ThemeMode)? onThemeChanged;
  final ThemeMode? currentThemeMode;

  HomeScreen({this.onThemeChanged, this.currentThemeMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> stops = [
    "6 Number Pulia",
    "Ajanta Chowk",
    "Aman Vihar",
    "Amrit Kunj",
    "Asthal",
    "Astley Hall",
    "ATS Tower",
    "Ballupur Chowk",
    "Baverly Hill Shalini School",
    "Bhel Chowk",
    "Bindal Pul",
    "Clement Town",
    "Clock Tower",
    "Connaught Place",
    "Cyber Police Station",
    "Darshan Lal Chowk",
    "Dilaram Chowk",
    "Dobhal Chowk",
    "Donali",
    "Maldevta",
    "DRDO",
    "Dwara Chowk",
    "Ekta Vihar",
    "FRI Main Gate",
    "Gandhi Park",
    "Garhi Cantt",
    "Gujrara Mansingh Road",
    "Hathi Khana Chowk",
    "Hill Grove School",
    "IMA Blood Bank",
    "Inder Bawa Marg",
    "ISBT",
    "ITI Niranjanpur",
    "IT Park",
    "Jakhan",
    "Jhanjra Hanuman Mandir",
    "Kaulagarh",
    "Kesharwala",
    "Kichuwala",
    "Kirsali Gaon",
    "Kishan Bhawan",
    "Kishan Nagar Chowk",
    "Kulhan Gaon",
    "Kwality Chowk",
    "Lal Pul",
    "Lansdowne Chowk",
    "LIC Building",
    "Madhuban Hotel",
    "Madhur Vihar",
    "Majra",
    "Maldevta Shiv Mandir",
    "Mandakini Vihar",
    "Mata Wala Bagh",
    "Matawala Bagh",
    "Mayur Vihar",
    "MDDA Colony",
    "Mussoorie Diversion",
    "N.W.T College",
    "Nalapani Chowk",
    "Nanda ki Chowki",
    "NIVH Front Gate",
    "Pacific Golf",
    "Pacific Mall",
    "Panditwari",
    "Parade Ground",
    "Patel Nagar Police Station",
    "Pearl Avenue Hotel",
    "PNB Patel Nagar",
    "Prem Nagar",
    "Prince Chowk",
    "Raipur",
    "Raipur Chungi",
    "Rajkiya Mahavidyalaya Maldevta",
    "Rajpur",
    "Railway Station",
    "Rispana Pul",
    "Ring Road Diversion",
    "Saharanpur Chowk",
    "Sahastradhara",
    "Sahastradhara Crossing",
    "Sachiwalaya",
    "Sai Mandir",
    "Seema Dwar",
    "Seemadwar",
    "SGRR",
    "Shimla Bypass",
    "Shiv Girdhar Nikunj",
    "Shiv Mandir Selaqui",
    "Shri Durga Enclave",
    "SIDCUL Gate 1",
    "St. Joseph Academy",
    "Subhash Nagar",
    "Sudhowala",
    "Survey Chowk",
    "Survey of India",
    "Tehri House/GRD",
    "Tehsil Chowk",
    "Tibetan Colony",
    "Touch Wood School",
    "Uttaranchal University",
    "Uttarakhand State Women’s Commission",
    "Uttarakhand Technical University",
    "Vikas Lok",
    "Yamuna Colony Chowk",
  ];

  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  LatLng? _currentPosition;
  bool _usingCurrentLocation = false;

  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.currentThemeMode ?? ThemeMode.light;
  }

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
    if (widget.onThemeChanged != null) {
      widget.onThemeChanged!(_themeMode);
    }
  }

  void _searchRoutes() {
    final source = _usingCurrentLocation
        ? 'Current Location'
        : _sourceController.text.trim();
    final destination = _destinationController.text.trim();

    if (source.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter/select the source'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    if (destination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter/select the destination'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          source: source,
          destination: destination,
          currentPosition: _currentPosition,
        ),
      ),
    );
  }

  Future<void> _detectLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _usingCurrentLocation = true;
        _sourceController.text = 'Current Location';
      });
    } catch (e) {
      setState(() {
        _currentPosition = null;
        _usingCurrentLocation = false;
        _sourceController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location permission denied or unavailable.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildAutocompleteField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return stops.where((stop) => stop
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          },
          onSelected: (String selection) {
            controller.text = selection;
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode focusNode,
              VoidCallback onFieldSubmitted) {
            // Link the internal controller with the external one
            if (controller.text != textEditingController.text) {
              textEditingController.text = controller.text;
              textEditingController.selection = controller.selection;
            }
            textEditingController.addListener(() {
              if (textEditingController.text != controller.text) {
                controller.text = textEditingController.text;
                controller.selection = textEditingController.selection;
              }
            });

            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
                icon: label == 'Source' && _usingCurrentLocation
                    ? Icon(Icons.my_location,
                        color: Theme.of(context).colorScheme.primary)
                    : Icon(Icons.place,
                        color: Theme.of(context).colorScheme.primary),
                suffixIcon: label == 'Source' && _usingCurrentLocation
                    ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _usingCurrentLocation = false;
                            _currentPosition = null;
                            controller.clear();
                          });
                        },
                      )
                    : null,
              ),
              enabled: enabled,
              style: TextStyle(fontSize: 16),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Row(
      children: <Widget>[
        Expanded(child: Divider(thickness: 1, color: Colors.grey.shade400)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "OR",
            style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ),
        Expanded(child: Divider(thickness: 1, color: Colors.grey.shade400)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Commute'),
        actions: [
          IconButton(
            tooltip: _themeMode == ThemeMode.light
                ? 'Switch to Dark Mode'
                : 'Switch to Light Mode',
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: child.key == ValueKey('icon1')
                      ? Tween<double>(begin: 0.75, end: 1).animate(animation)
                      : Tween<double>(begin: 1, end: 0.75).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: _themeMode == ThemeMode.light
                  ? Icon(Icons.dark_mode, key: ValueKey('icon1'))
                  : Icon(Icons.light_mode, key: ValueKey('icon2')),
            ),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section line with label
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Expanded(child: Divider(thickness: 2)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Plan Your Commute",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 2)),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: _detectLocation,
                icon: Icon(Icons.my_location),
                label: Text('Detect Location'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            _buildSeparator(),
            SizedBox(height: 20),
            _buildAutocompleteField(
                label: 'Source',
                controller: _sourceController,
                enabled: !_usingCurrentLocation),
            _buildAutocompleteField(
                label: 'Destination',
                controller: _destinationController,
                enabled: true),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _searchRoutes,
                child: Text('Search Routes'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
            // 👇 Here's the footer line you wanted
            SizedBox(height: 40),
            // Footer line at the bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  Expanded(child: Divider(thickness: 2)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Powered by: Real Time Data - Dehradun",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy ResultsScreen to illustrate route result page
// Results Screen
class ResultsScreen extends StatelessWidget {
  final String source;
  final String destination;
  final LatLng? currentPosition;

  ResultsScreen({
    required this.source,
    required this.destination,
    this.currentPosition,
  });

  Widget _buildRouteCard(String title, String description, Color color) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      shadowColor: color.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
            ),
          ],
        ),
      ),
    );
  }

  // Dummy route data for illustration
  final List<Map<String, String>> _routes = [
    {
      "title": "Route A",
      "description":
          "Via Parade Ground, takes approx 25 mins. Best for traffic conditions."
    },
    {
      "title": "Route B",
      "description": "Via ISBT, takes approx 30 mins. Less walking."
    },
    {
      "title": "Route C",
      "description": "Via Clock Tower, scenic route, takes approx 28 mins."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routes from $source to $destination'),
      ),
      body: Column(
        children: [
          // 👇 Here's the footer line you wanted
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              "Powered by: Real Time Data - Dehradun",
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FlutterMap(
              options: MapOptions(
                center: currentPosition ?? LatLng(30.3165, 78.0322), // Dehradun
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    if (currentPosition != null)
                      Marker(
                        point: currentPosition!,
                        builder: (ctx) => Icon(Icons.my_location,
                            color: Colors.blue, size: 36),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _routes.length,
              itemBuilder: (context, index) {
                final route = _routes[index];
                final colors = [
                  Colors.indigo,
                  Colors.deepPurple,
                  Colors.teal,
                ];
                return _buildRouteCard(
                    route['title']!, route['description']!, colors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
