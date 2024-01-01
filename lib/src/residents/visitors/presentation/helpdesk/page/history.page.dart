import 'package:flutter/material.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/page/my.complaints.page.dart';
import 'package:rnginfra/src/residents/visitors/presentation/helpdesk/page/my.reactions.page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: Theme.of(context).colorScheme.onBackground,
          elevation: 0.2,
          centerTitle: false,
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.onBackground,
            tabs: const [
              Tab(
                text: 'Raised Complaints',
              ),
              Tab(
                text: 'Reactions',
              ),
            ],
          ),
          title: const Text('Activities'),
        ),
        body: const TabBarView(
          children: [MyComplaintsPage(), MyReactionsPage()],
        ),
      ),
    );
  }
}
