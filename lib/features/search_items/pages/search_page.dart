import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/repositories/search/search_repository.dart';

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
        title: const Text("Search"),
        leading: const BackButton(),
        actions: const [Icon(Icons.notifications_none)],
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search for clothes...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) {
            context.read<SearchBloc>().add(SearchTextChanged(value));
          },
        ),
      ),
    );
  }

  Widget _buildRecentSearches(BuildContext context, List<String> recent) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Recent Searches"),
            GestureDetector(
              onTap: () {
                context.read<SearchBloc>().add(ClearSearchHistory());
              },
              child: const Text("Clear all", style: TextStyle(color: Colors.blue)),
            )
          ],
        ),
        ...recent.map((e) => ListTile(
          title: Text(e),
          onTap: () {
            _controller.text = e;
            context.read<SearchBloc>().add(SearchTextChanged(e));
          },
        )),
      ],
    );
  }

  Widget _buildResults(List results) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/shirt.png"), // replace with real image
          ),
          title: Text(item.title),
          subtitle: Text("\$${item.price}"),
          trailing: const Icon(Icons.open_in_new),
        );
      },
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 60, color: Colors.grey),
          SizedBox(height: 16),
          Text("No Results Found!"),
          Text("Try a similar word or something more general."),
        ],
      ),
    );
  }
}
