


import 'package:movie/presentation/pages/movies/watchlist_page.dart';
import 'package:tv/presentation/pages/tv/watchlist_tv_page.dart';
import 'package:flutter/material.dart';

class TabPager extends StatefulWidget {
  static const routeName = '/tab_page';
  const TabPager({Key? key}) : super(key: key);

  @override
  State<TabPager> createState() => _TabPagerState();
}

class _TabPagerState extends State<TabPager> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watchlist'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: TabBar(
                        unselectedLabelColor: Colors.white,
                        labelColor: Colors.black,
                        indicatorColor: Colors.white,
                        indicatorWeight: 2,
                        indicator: BoxDecoration(
                            color: Colors.white,borderRadius: BorderRadius.circular(5)
                        ),
                        controller: tabController,
                        tabs: const [
                          Tab(text: "Movie",),
                          Tab(text: "TV",),
                        ],
                      ),
                    )
                  ],
                ),
              ),
               Expanded(child: TabBarView(
                 controller: tabController,
                 children: const [
                   WatchlistPage(),
                   WatchlistTvPage()
                 ],
               ))
            ],
          ),
        ),
      ),
    );
  }
}
