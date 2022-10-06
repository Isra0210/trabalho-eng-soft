import 'package:flutter/material.dart';
import 'package:hackday/admin/model/report_view_model.dart';

class ReportComponent extends StatelessWidget {
  const ReportComponent({required this.report, Key? key}) : super(key: key);

  final ReportViewModel report;

  @override
  Widget build(BuildContext context) {
    final bool isSuccessfully = report.total == report.totalSelected ||
        report.total ==
            (double.parse(report.totalSelected) -
                    double.parse(report.cashChange))
                .toString();

    return Container(
      height: 120,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
          ),
        ],
        border: Border.all(
          color: isSuccessfully ? Colors.green : Colors.red,
          width: 2
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Nome: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                report.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Total: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "R\$ ${report.total}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "Total selecionado: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "R\$ ${report.totalSelected}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "troco: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "R\$ ${report.cashChange}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
