// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:magic_number/UI/home.dart';
import 'package:magic_number/models/user.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class Page_Score extends StatefulWidget {
  const Page_Score({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Page_ScoreState createState() => _Page_ScoreState();
}

class _Page_ScoreState extends State<Page_Score> {
  int? _sortColumnIndex;
  final List<String> _columns = ['Nom du joueur ', 'Score du joueur', 'Niveau'];
  bool estCroissant = true;
  List<User> users = [];
  int _rowsPerPage = 8;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _sortColumnIndex = 0;
    getUsers(Provider.of<Database>(context, listen: false)).then((value) {
      setState(() {
        users = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Score'),
      ),
      body: FutureBuilder<List<User>>(
        future: getUsers(database),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Erreur: ${snapshot.error.toString()}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('Pas de score enregistré'));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  PaginatedDataTable(
                    header: const Text('Users'),
                    rowsPerPage: _rowsPerPage,
                    availableRowsPerPage: const <int>[
                      5,
                      8,
                      10,
                      20,
                      30,
                      50,
                      100
                    ],
                    onRowsPerPageChanged: (int? value) {
                      setState(() {
                        _rowsPerPage = value!;
                      });
                    },
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: estCroissant,
                    columns: getColonnes(_columns),
                    source: _DataSource(context, users),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Appeler la fonction pour supprimer les scores
                      deleteScores(database);
                    },
                    child: const Text('Supprimer les scores'),
                  )
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Score',
            ),
          ],
          onTap: (value) => setState(() {
                currentIndex = value;
                if (currentIndex == 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Page_Score()),
                    (Route<dynamic> route) => false,
                  );
                }
              })),
    );
  }

  Future<List<User>> getUsers(Database database) async {
    try {
      final List<Map<String, dynamic>> maps = await database.query('user');
      if (maps.isNotEmpty) {
        return maps
            .map((userMap) => User(
                  id: userMap['id'],
                  name: userMap['name'],
                  score: userMap['score'],
                  niveau: userMap['niveau'],
                ))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error querying database: $e');
      throw Exception('Error querying database');
    }
  }

  List<DataColumn> getColonnes(List<String> colonnes) => colonnes
      .map((String colonne) => DataColumn(
            label: Text(colonne),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getLignes() => users.map((User user) {
        var cells = [user.name, user.score, user.niveau]; // Add 'niveau' cell
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool croissant) {
    print('Sorting column: $columnIndex');

    late List<User> sortedUsers;
    if (columnIndex == 0) {
      sortedUsers = List.from(users)
        ..sort(
            (user1, user2) => compareString(croissant, user1.name, user2.name));
      print(" Liste refaite par NOM $sortedUsers");
    } else if (columnIndex == 1) {
      sortedUsers = List.from(users)
        ..sort(
            (user1, user2) => compareInt(croissant, user1.score, user2.score));
      print(" Liste refaite par SCORE $sortedUsers");
    }
    setState(() {
      _sortColumnIndex = columnIndex;
      estCroissant = croissant;
      users = sortedUsers;
    });
  }

  int compareString(bool croissant, String value1, String value2) {
    return croissant ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  int compareInt(bool croissant, int valeur1, int valeur2) {
    if (valeur1 < valeur2) {
      return croissant ? -1 : 1;
    } else if (valeur1 > valeur2) {
      return croissant ? 1 : -1;
    } else {
      return 0;
    }
  }

  void deleteScores(Database database) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content:
              const Text('Êtes-vous sûr de vouloir supprimer les scores ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                deleteScoresConfirmed(database);
                Navigator.of(context).pop();
              },
              child: const Text('Confirmer'),
            ),
          ],
        );
      },
    );
  }

  void deleteScoresConfirmed(Database database) {
    database.delete('user').then((value) {
      setState(() {
        users = [];
      });
    }).catchError((e) {
      print('Error deleting scores: $e');
    });
  }
}

// Update the _DataSource class
class _DataSource extends DataTableSource {
  final BuildContext context;
  final List<User> _users;

  _DataSource(this.context, this._users);

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _users.length) return null;
    final User user = _users[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(user.name)),
        DataCell(Text(user.score.toString())),
        DataCell(Text(user.niveau.toString())), 
      ],
    );
  }
  
@override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _users.length;

  @override
  int get selectedRowCount => 0;
}
