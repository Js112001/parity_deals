import 'package:deals/modules/presentation/bloc/home_bloc.dart';
import 'package:deals/modules/presentation/views/default_tab_controller_listener.dart';
import 'package:deals/modules/presentation/widgets/deals_listing_widget.dart';
import 'package:deals/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title, required this.tabs});

  final String title;
  final List<String> tabs;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      child: DefaultTabControllerListener(
        onTabChanged: (value) {
          BlocProvider.of<HomeBloc>(context).add(InitialEvent());
          switch (value) {
            case 0:
              BlocProvider.of<HomeBloc>(context).add(GetTopDealsEvent(1));
            case 1:
              BlocProvider.of<HomeBloc>(context).add(GetPopularDealsEvent(1));
            case 2:
              BlocProvider.of<HomeBloc>(context).add(GetFeaturedDealsEvent(1));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: widget.tabs
                  .map(
                    (tabName) => Tab(
                      text: tabName,
                    ),
                  )
                  .toList(),
            ),
            title: const Text('Deals'),
          ),
          body: TabBarView(
            children: [
              DealsListingWidget(dealType: DealTypes.top),
              DealsListingWidget(dealType: DealTypes.popular),
              DealsListingWidget(dealType: DealTypes.featured),
            ],
          ),
        ),
      ),
    );
  }
}
