import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clonify/logic/suggestions.dart';
import 'package:clonify/components/home/suggestion.dart';

class HomeScreen extends StatelessWidget {
  @override
  build(context) {
    final suggestions = Provider.of<Suggestions>(context);

    if (!suggestions.itemsFetched) {
      suggestions.fetchHomeScreen();
    }

    return SafeArea(
        key: ValueKey<int>(1),
        child: !suggestions.itemsFetched
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: suggestions.suggestions.length,
                itemBuilder: (context, ind) {
                  final sug = suggestions.suggestions[ind];
                  return SuggestionWidget(sug);
                }));
  }
}
