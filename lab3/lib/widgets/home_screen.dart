import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab3_flu/config.dart' as config;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<dynamic> projects = [];
  String codingLanguage = "JavaScript";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String sevenDaysAgo = DateTime.now()
        .subtract(const Duration(days: 7))
        .toString()
        .split(' ')[0];

    final Uri uri = Uri.https(
      'api.github.com',
      '/search/repositories',
      {
        'q': 'created:>$sevenDaysAgo language:$codingLanguage',
        'sort': 'stars',
        'order': 'desc',
      },
    );

    final http.Response response = await http.get(
      uri,
      headers: {
        'Accept': 'application/vnd.github.preview',
        'Authorization': 'Bearer ${config.apiKey}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        log(response.body);
        projects = json.decode(response.body)['items'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton(
          hint: const Text("Language"),
          items: config.possibleLanguages
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                codingLanguage = newValue;
              });
              projects = [];
              fetchData();
            }
          },
        ),
      ),
      body: projects.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: projects.length,
              itemBuilder: (BuildContext context, int index) {
                return ProjectCard(
                  project: projects[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProjectDetailsScreen(project: projects[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final dynamic project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  project['name'],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star),
                  Text('${project['watchers_count']}'),
                ],
              ),
            ],
          ),
          subtitle: Text(project['description'] ?? 'No description available'),
        ),
      ),
    );
  }
}

class ProjectDetailsScreen extends StatelessWidget {
  final dynamic project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Description: ${project['description'] ?? 'No description available'}'),
            const SizedBox(height: 16.0),
            Text('Language: ${project['language'] ?? 'Unknown'}'),
            const SizedBox(height: 16.0),
            Text('Stars : ${project['watchers_count']}'),
            const SizedBox(height: 16.0),
            Text('HTML URL: ${project['html_url']}'),
          ],
        ),
      ),
    );
  }
}
