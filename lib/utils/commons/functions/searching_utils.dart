import '../../../models/request/paging_model.dart';
import '../../enums/searching_type_enum.dart';

SearchingType getTypeSeaching(PagingModel model) {
  if (model.searchContent != null &&
      model.sortContent == null &&
      model.filterContent == null) {
    return SearchingType.search;
  } else if (model.searchContent == null &&
      model.sortContent != null &&
      model.filterContent == null) {
    if (model.sortContent == SearchingType.sortacs.type) {
      return SearchingType.sortacs;
    }
    return SearchingType.sortdes;
  } else if (model.searchContent == null &&
      model.sortContent == null &&
      model.filterContent != null) {
    return SearchingType.filter;
  } else if (model.searchContent != null &&
      model.sortContent != null &&
      model.filterContent == null) {
    if (model.sortContent == SearchingType.sortacs.type) {
      return SearchingType.searchsortasc;
    }
    return SearchingType.searchsortdesc;
  } else if (model.searchContent != null &&
      model.sortContent == null &&
      model.filterContent != null) {
    return SearchingType.searchfilter;
  } else if (model.searchContent == null &&
      model.sortContent != null &&
      model.filterContent != null) {
    if (model.sortContent == SearchingType.sortacs.type) {
      return SearchingType.sortascfilter;
    }
    return SearchingType.sortdescfilter;
  } else if (model.searchContent != null &&
      model.sortContent != null &&
      model.filterContent != null) {
    if (model.sortContent == SearchingType.sortacs.type) {
      return SearchingType.searchsortascfilter;
    }
    return SearchingType.searchsortdescfilter;
  } else {
    return SearchingType.normal;
  }
}
