class Models {
  final String image;
  final String title;
  final String text;
  Models({required this.image, required this.title, required this.text});
}

List<Models> models = [
  Models(
      image: 'assets/quick_search.jpg',
      title: 'Quick Search',
      text: 'Set your location to start exploring restaurants around you'),
  Models(
      image: 'assets/variety_of_food.png',
      title: 'Variety Of Food',
      text: 'Set your location to start exploring restaurants around you'),
  Models(
      image: 'assets/search_place',
      title: 'Search Place',
      text: 'Set your location to start exploring restaurants around you'),
];
