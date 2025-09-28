import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/data/repositories/search/search_repository.dart';
import 'package:store_app/features/common/bottom_nav_widget.dart';

import '../managers/search_bloc.dart';
import '../managers/search_events.dart';
import '../managers/search_state.dart';

class SearchPage extends StatelessWidget {
  final SearchRepository repository;
  const SearchPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(repository: repository),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search for clothes...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: (value) {
            context.read<SearchBloc>().add(SearchTextChanged(value));
          },
        ),
        actions: const [Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: Icon(Icons.notifications_none),
        )],
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          switch (state.status) {
            case SearchStatus.initial:
              return _buildRecentSearches(context, state.recentSearches);
            case SearchStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case SearchStatus.success:
              return _buildResults(state.results);
            case SearchStatus.empty:
              return _buildEmpty();
            case SearchStatus.failure:
              return Center(child: Text("Error: ${state.error}"));
          }
        },
      ),
      bottomNavigationBar: CustomBottomNav(currentIndex: 1),
    );
  }

  Widget _buildRecentSearches(BuildContext context, List<String> recent) {
    if (recent.isEmpty) {
      return const Center(child: Text("No recent searches"));
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Recent Searches", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: () {
                  context.read<SearchBloc>().add(ClearSearchHistory());
                },
                child: const Text("Clear all", style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: recent.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = recent[index];
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    _controller.text = item;
                    context.read<SearchBloc>().add(SearchTextChanged(item));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(List results) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = results[index];
        return  ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.image,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text("\$${item.price}", style: const TextStyle(color: Colors.black87)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Navigate to detail page with productId
            context.go('/product/${item.id}');
          },
        );

      },
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text("No Results Found!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          SizedBox(height: 4),
          Text("Try a similar word or something more general.",
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
