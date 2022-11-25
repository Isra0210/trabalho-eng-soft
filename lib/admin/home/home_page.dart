import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackday/admin/home/components/report_component.dart';
import 'package:hackday/admin/model/report_view_model.dart';
import 'package:hackday/pages/levels/levels_presenter.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.presenter, Key? key}) : super(key: key);

  static const route = '/home';
  final ILevelsPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 210, 192, 1),
        title: Text(
          'Relatório',
          style: TextStyle(
            color: Colors.blueGrey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.logout, color: Colors.blueGrey.shade900),
          onPressed: () => FirebaseAuth.instance.signOut(),
        ),
      ),
      body: StreamBuilder<List<ReportViewModel>>(
        stream: presenter.getReports(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0XFF1e224c)),
              ),
            );
          }

          if (snapshot.hasData) {
            List<ReportViewModel> reports = snapshot.data!;
            if (reports.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum relatório encontrado!',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return ListView(
                shrinkWrap: true,
                children: [
                  ...reports.map(
                    (report) => ReportComponent(report: report),
                  )
                ],
              );
            }
          }

          return Text('${snapshot.data}');
        },
      ),
    );
  }
}
