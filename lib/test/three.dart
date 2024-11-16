// First, let's define our models
class SearchLocation {
  final String route;
  final String id;
  final DateTime timestamp;

  SearchLocation({
    required this.route,
    required this.id,
    required this.timestamp,
  });
}

// Events
abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String from;
  final String to;
  SearchQueryChanged({required this.from, required this.to});
}

class LoadRecentSearches extends SearchEvent {}

class AddRecentSearch extends SearchEvent {
  final SearchLocation location;
  AddRecentSearch(this.location);
}

// States
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<SearchLocation> recentSearches;
  final String from;
  final String to;

  SearchLoaded({
    required this.recentSearches,
    this.from = '',
    this.to = '',
  });

  SearchLoaded copyWith({
    List<SearchLocation>? recentSearches,
    String? from,
    String? to,
  }) {
    return SearchLoaded(
      recentSearches: recentSearches ?? this.recentSearches,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}

// BLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<LoadRecentSearches>(_onLoadRecentSearches);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<AddRecentSearch>(_onAddRecentSearch);
  }

  Future<void> _onLoadRecentSearches(
    LoadRecentSearches event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    // In a real app, load from local storage or API
    final recentSearches = [
      SearchLocation(
        route: 'Alger - Blida - Tissemislt',
        id: '1',
        timestamp: DateTime.now(),
      ),
      // Add more recent searches
    ];
    emit(SearchLoaded(recentSearches: recentSearches));
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      emit(currentState.copyWith(
        from: event.from,
        to: event.to,
      ));
    }
  }

  Future<void> _onAddRecentSearch(
    AddRecentSearch event,
    Emitter<SearchState> emit,
  ) async {
    if (state is SearchLoaded) {
      final currentState = state as SearchLoaded;
      final updatedSearches = List<SearchLocation>.from(currentState.recentSearches)
        ..insert(0, event.location);
      emit(currentState.copyWith(recentSearches: updatedSearches));
    }
  }
}

// Reusable Components
class LocationInput extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChanged;
  final IconData icon;
  final Color iconColor;

  const LocationInput({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentSearchItem extends StatelessWidget {
  final SearchLocation location;
  final VoidCallback onTap;

  const RecentSearchItem({
    Key? key,
    required this.location,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.location_on, color: Colors.green),
      ),
      title: Text(
        'USER',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(location.route),
      onTap: onTap,
    );
  }
}

// Main Search Screen
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc()..add(LoadRecentSearches()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchCard(context, state),
                    SizedBox(height: 24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'RECENT',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildRecentSearches(context, state),
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildSearchCard(BuildContext context, SearchLoaded state) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            LocationInput(
              label: 'From:',
              value: state.from,
              onChanged: (value) => context.read<SearchBloc>().add(
                SearchQueryChanged(from: value, to: state.to),
              ),
              icon: Icons.circle,
              iconColor: Colors.green,
            ),
            Divider(),
            LocationInput(
              label: 'To:',
              value: state.to,
              onChanged: (value) => context.read<SearchBloc>().add(
                SearchQueryChanged(from: state.from, to: value),
              ),
              icon: Icons.location_on,
              iconColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches(BuildContext context, SearchLoaded state) {
    return ListView.separated(
      itemCount: state.recentSearches.length,
      separatorBuilder: (context, index) => Divider(height: 1),
      itemBuilder: (context, index) {
        final search = state.recentSearches[index];
        return RecentSearchItem(
          location: search,
          onTap: () {
            // Handle recent search tap
          },
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', false),
            _buildNavItem(Icons.search, 'Search', true),
            _buildNavItem(Icons.message, 'Messages', false),
            _buildNavItem(Icons.settings, 'Settings', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.green : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.green : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
