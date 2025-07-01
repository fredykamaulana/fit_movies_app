enum NavigationRoutes {
  signin(name: '/signin'),
  register(name: '/register'),
  movieList(name: '/movie/list'),
  movieDetail(name: '/movie/detail'),
  favourite(name: '/movie/favourite');

  const NavigationRoutes({required this.name});
  final String name;
}
