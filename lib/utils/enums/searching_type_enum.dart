enum SearchingType {
  normal('normal'),
  search('search'),
  sortacs('sortasc'),
  sortdes('sortdes'),
  filter('filter'),
  searchsortasc('searchsortasc'),
  searchsortdesc('searchsortdesc'),
  searchfilter('searchfilter'),
  sortascfilter('sortascfilter'),
  sortdescfilter('sortdescfilter'),
  searchsortascfilter('searchsortascfilter'),
  searchsortdescfilter('searchsortdescfilter');

  final String type;
  const SearchingType(this.type);
}
