import 'package:app_good_taste/app/page/production_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductionDetailsListPage extends StatefulWidget {
  const ProductionDetailsListPage({super.key});

  @override
  State<ProductionDetailsListPage> createState() =>
      _ProductionDetailsListPage();
}

class _ProductionDetailsListPage extends State<ProductionDetailsListPage> {
  final List<Map<String, dynamic>> productionDetailsListPage = [
    {"date": "11/07/2023", "value-entry": 40, "value-leave": 20, "profit": 20},
    {"date": "11/07/2023", "value-entry": 40, "value-leave": 20, "profit": 20},
    {"date": "11/07/2023", "value-entry": 40, "value-leave": 20, "profit": 20},
    {"date": "11/07/2023", "value-entry": 40, "value-leave": 20, "profit": 20},
    {"date": "11/07/2023", "value-entry": 40, "value-leave": 20, "profit": 20},
    {"date": "11/07/2023", "value-entry": 40, "value-leave": 20, "profit": 20},
    {"date": "12/07/2023", "value-entry": 30, "value-leave": 10, "profit": 20},
    {"date": "16/07/2023", "value-entry": 50, "value-leave": 25, "profit": 25},
    {"date": "17/07/2023", "value-entry": 60, "value-leave": 30, "profit": 30},
    {"date": "12/07/2023", "value-entry": 30, "value-leave": 10, "profit": 20},
    {"date": "16/07/2023", "value-entry": 50, "value-leave": 25, "profit": 25},
    {"date": "17/07/2023", "value-entry": 60, "value-leave": 30, "profit": 30},
  ];

  bool _sortAscending = true;
  int _sortColumnIndex = 0;

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      productionDetailsListPage.sort((a, b) {
        final aValue = a.values.toList()[columnIndex];
        final bValue = b.values.toList()[columnIndex];

        if (aValue is String && bValue is String) {
          return ascending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        } else if (aValue is num && bValue is num) {
          return ascending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        }

        return 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detalhes das produções",
          style: TextStyle(fontSize: 25),
        ),
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.close,
            size: 35,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: const Text("Data"),
                        onSort: (columnIndex, ascending) {
                          _onSort(columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label: const Text("V. Entrada"),
                        onSort: (columnIndex, ascending) {
                          _onSort(columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label: const Text("V. Saída"),
                        onSort: (columnIndex, ascending) {
                          _onSort(columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label: const Text("Lucro"),
                        onSort: (columnIndex, ascending) {
                          _onSort(columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label: const Text("+ Detalhes"),
                        onSort: (columnIndex, ascending) {
                          _onSort(columnIndex, ascending);
                        },
                      ),
                    ]
                        .map(
                          (column) => DataColumn(
                            label: column.label,
                            onSort: column.onSort,
                            numeric: column.numeric,
                            tooltip: column.tooltip,
                            // Adicione a propriedade flex:
                          ),
                        )
                        .toList(),
                    rows:
                        productionDetailsListPage.asMap().entries.map((entry) {
                      final index = entry.key;
                      final data = entry.value;
                      final isEvenRow = index % 2 == 0;
                      final rowColor =
                          isEvenRow ? Colors.white : Colors.grey[200];

                      return DataRow(
                        color: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return rowColor?.withOpacity(
                                0.5); // Opacidade reduzida quando a linha estiver selecionada
                          } else {
                            return rowColor;
                          }
                        }),
                        cells: [
                          DataCell(
                            Text(data['date']),
                          ),
                          DataCell(
                            Text(
                              NumberFormat("R\$ #0.00", "PT-BR")
                                  .format(data['value-entry']),
                            ),
                          ),
                          DataCell(
                            Text(
                              NumberFormat("R\$ #0.00", "PT-BR")
                                  .format(data['value-leave']),
                            ),
                          ),
                          DataCell(
                            Text(
                              NumberFormat("R\$ #0.00", "PT-BR")
                                  .format(data['profit']),
                            ),
                          ),
                          DataCell(
                            IconButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ProductionDetailsPage(),
                                ),
                              ),
                              icon: Icon(
                                Icons.add_chart_sharp,
                                size: 35,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
