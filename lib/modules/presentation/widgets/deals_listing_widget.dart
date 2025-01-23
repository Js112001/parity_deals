import 'dart:async';

import 'package:deals/modules/domain/entities/deal_entity.dart';
import 'package:deals/modules/presentation/bloc/home_bloc.dart';
import 'package:deals/modules/presentation/widgets/deal_card_widget.dart';
import 'package:deals/utils/custom_logger.dart';
import 'package:deals/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealsListingWidget extends StatefulWidget {
  const DealsListingWidget({super.key, required this.dealType});

  final DealTypes dealType;

  @override
  State<DealsListingWidget> createState() => _DealsListingWidgetState();
}

class _DealsListingWidgetState extends State<DealsListingWidget> {
  late ScrollController _scrollController;
  Timer? _debounce;
  List<DealEntity> deals = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    // deals = [];
    switch (widget.dealType) {
      case DealTypes.top:
        BlocProvider.of<HomeBloc>(context).add(GetTopDealsEvent(1));
      case DealTypes.featured:
        BlocProvider.of<HomeBloc>(context).add(GetFeaturedDealsEvent(1));
      case DealTypes.popular:
        BlocProvider.of<HomeBloc>(context).add(GetPopularDealsEvent(1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        CustomLogger.i('[State]: ${state.runtimeType}');
        if (state is ErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "statusCode: ${state.statusCode} Error: ${state.message}",
                textAlign: TextAlign.center,
              )
            ],
          );
        } else if (state is SuccessState) {
          deals = state.deals;
          CustomLogger.i('[Deals]: ${deals.first.id}');
          return RefreshIndicator(
            onRefresh: () async {
              switch (widget.dealType) {
                case DealTypes.top:
                  BlocProvider.of<HomeBloc>(context).add(GetTopDealsEvent(1));
                case DealTypes.featured:
                  BlocProvider.of<HomeBloc>(context)
                      .add(GetFeaturedDealsEvent(1));
                case DealTypes.popular:
                  BlocProvider.of<HomeBloc>(context)
                      .add(GetPopularDealsEvent(1));
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: deals.length,
                    cacheExtent: MediaQuery.sizeOf(context).height,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return DealCardWidget(deal: deals[index]);
                    },
                  ),
                ),
                if (state.isPaginated)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          );
        }
      },
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      page = page + 1;
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      } else {
        _debounce = Timer(
          Duration(milliseconds: 500),
          () {
            switch (widget.dealType) {
              case DealTypes.top:
                BlocProvider.of<HomeBloc>(context).add(GetTopDealsEvent(page));
              case DealTypes.featured:
                BlocProvider.of<HomeBloc>(context)
                    .add(GetFeaturedDealsEvent(page));
              case DealTypes.popular:
                BlocProvider.of<HomeBloc>(context)
                    .add(GetPopularDealsEvent(page));
            }
          },
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debounce?.cancel();
    deals = [];
    CustomLogger.i('${widget.dealType} [Disposed]');
    super.dispose();
  }
}
