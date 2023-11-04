import 'package:admin_dashboard/models/http/category.dart';
import 'package:flutter/material.dart';

class CategoriesDTS extends DataTableSource {

  final List<Categoria> categorias;
  final BuildContext context;

  CategoriesDTS(this.context, this.categorias);

  @override
  DataRow? getRow(int index) {

    final categoria = categorias[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(categoria.id)),
        DataCell(Text(categoria.nombre)),
        DataCell(Text(categoria.usuario.nombre)),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.8),),
                onPressed: (){
                  final dialog = AlertDialog(
                    title: Text('¿Esta seguro de borralo?'),
                    content: Text('Borrar definitivamente ${categoria.nombre}'),
                    actions: [
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }
                      ),
                      TextButton(
                        child: Text('Si, borrar'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (_) => dialog);
                }, 
              ),
            ],
         ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categorias.length;

  @override
  int get selectedRowCount => 0;
}
