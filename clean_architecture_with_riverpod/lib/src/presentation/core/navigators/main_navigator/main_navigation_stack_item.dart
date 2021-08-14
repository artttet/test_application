import 'package:flutter/widgets.dart';

mixin MainNavigationStackItemMixin {
  @optionalTypeArgs
  T when<T extends Object?>({
    required T Function() onNotFound,
    required T Function() onUsersList,
    required T Function(int) onUserDetails,
    required T Function(int) onPostsList,
    required T Function(int) onPostDetails,
    required T Function(int) onAlbumsList,
    required T Function(int) onAlbumDetails,
  }) => throw UnimplementedError();

  @optionalTypeArgs
  T maybeWhen<T extends Object?>({
    T Function()? onNotFound,
    T Function()? onUsersList,
    T Function(int)? onUserDetails,
    T Function(int)? onPostsList,
    T Function(int)? onPostDetails,
    T Function(int)? onAlbumsList,
    T Function(int)? onAlbumDetails,
    required T orElse()
  }) => throw UnimplementedError();
}

class MainNavigationStackItem with MainNavigationStackItemMixin {
  const MainNavigationStackItem();

  const factory MainNavigationStackItem.notFound() = MainNavigationStackItemNotFound;
  const factory MainNavigationStackItem.usersList() = MainNavigationStackItemUsersList;
  const factory MainNavigationStackItem.userDetails({required int userId}) = MainNavigationStackItemUserDetails;
  const factory MainNavigationStackItem.postsList({required int userId}) = MainNavigationStackItemPostsList;
  const factory MainNavigationStackItem.postDetails({required int postId}) = MainNavigationStackItemPostDetails;
  const factory MainNavigationStackItem.albumsList({required int userId}) = MainNavigationStackItemAlbumsList;
  const factory MainNavigationStackItem.albumsDetails({required int albumId}) = MainNavigationStackItemAlbumDetails;
}

/*
    Not Found
*/

class _MainNavigationStackItemNotFound implements MainNavigationStackItemNotFound {
  const _MainNavigationStackItemNotFound();

  @override
  T when<T extends Object?>({
    required T Function() onNotFound,
    required T Function() onUsersList,
    required T Function(int) onUserDetails,
    required T Function(int) onPostsList,
    required T Function(int) onPostDetails,
    required T Function(int) onAlbumsList,
    required T Function(int) onAlbumDetails
  }) {
    return onNotFound.call();
  }

  @override
  T maybeWhen<T extends Object?>({
    T Function()? onNotFound,
    T Function()? onUsersList,
    T Function(int)? onUserDetails,
    T Function(int)? onPostsList,
    T Function(int)? onPostDetails,
    T Function(int)? onAlbumsList,
    T Function(int)? onAlbumDetails,
    required T orElse()
  }) {
    if (onNotFound != null) return onNotFound.call();
    else return orElse();
  }
}

abstract class MainNavigationStackItemNotFound implements MainNavigationStackItem {
  const factory MainNavigationStackItemNotFound() = _MainNavigationStackItemNotFound;
}

/*
    Users List
*/

class _MainNavigationStackItemUsersList implements MainNavigationStackItemUsersList {
  const _MainNavigationStackItemUsersList();

  @override
  T when<T extends Object?>({
    required T Function() onNotFound,
    required T Function() onUsersList,
    required T Function(int) onUserDetails,
    required T Function(int) onPostsList,
    required T Function(int) onPostDetails,
    required T Function(int) onAlbumsList,
    required T Function(int) onAlbumDetails
  }) {
    return onUsersList.call();
  }

  @override
  T maybeWhen<T extends Object?>({
    T Function()? onNotFound,
    T Function()? onUsersList,
    T Function(int)? onUserDetails,
    T Function(int)? onPostsList,
    T Function(int)? onPostDetails,
    T Function(int)? onAlbumsList,
    T Function(int)? onAlbumDetails,
    required T orElse()
  }) {
    if (onUsersList != null) return onUsersList.call();
    else return orElse();
  }
}

abstract class MainNavigationStackItemUsersList implements MainNavigationStackItem {
  const factory MainNavigationStackItemUsersList() = _MainNavigationStackItemUsersList;
}

/*
    User Details
*/

class _MainNavigationStackItemUserDetails implements MainNavigationStackItemUserDetails {
  const _MainNavigationStackItemUserDetails({required this.userId});

  @override
  final int userId;

  @override
  T when<T extends Object?>({
    required T Function() onNotFound,
    required T Function() onUsersList,
    required T Function(int) onUserDetails,
    required T Function(int) onPostsList,
    required T Function(int) onPostDetails,
    required T Function(int) onAlbumsList,
    required T Function(int) onAlbumDetails
  }) {
    return onUserDetails.call(userId);
  }

  @override
  T maybeWhen<T extends Object?>({
    T Function()? onNotFound,
    T Function()? onUsersList,
    T Function(int)? onUserDetails,
    T Function(int)? onPostsList,
    T Function(int)? onPostDetails,
    T Function(int)? onAlbumsList,
    T Function(int)? onAlbumDetails,
    required T orElse()
  }) {
    if (onUserDetails != null) return onUserDetails.call(userId);
    else return orElse();
  }
}

abstract class MainNavigationStackItemUserDetails implements MainNavigationStackItem{
  const factory MainNavigationStackItemUserDetails({required int userId})
      = _MainNavigationStackItemUserDetails;

  int get userId => throw UnimplementedError();
}

/*
    Posts List
*/

class _MainNavigationStackItemPostsList implements MainNavigationStackItemPostsList {
  const _MainNavigationStackItemPostsList({required this.userId});

  @override
  final int userId;

  @override
  T when<T extends Object?>({
    required T Function() onNotFound,
    required T Function() onUsersList,
    required T Function(int) onUserDetails,
    required T Function(int) onPostsList,
    required T Function(int) onPostDetails,
    required T Function(int) onAlbumsList,
    required T Function(int) onAlbumDetails
  }) {
    return onPostsList.call(userId);
  }

  @override
  T maybeWhen<T extends Object?>({
    T Function()? onNotFound,
    T Function()? onUsersList,
    T Function(int)? onUserDetails,
    T Function(int)? onPostsList,
    T Function(int)? onPostDetails,
    T Function(int)? onAlbumsList,
    T Function(int)? onAlbumDetails,
    required T orElse()
  }) {
    if (onPostsList != null) return onPostsList.call(userId);
    else return orElse();
  }
}

abstract class MainNavigationStackItemPostsList implements MainNavigationStackItem{
  const factory MainNavigationStackItemPostsList({required int userId})
      = _MainNavigationStackItemPostsList;

  int get userId => throw UnimplementedError();
}

/*
    Post Details
*/

class _MainNavigationStackItemPostDetails implements MainNavigationStackItemPostDetails {
  const _MainNavigationStackItemPostDetails({required this.postId});

  @override
  final int postId;

  @override
  T when<T extends Object?>({
    required T Function() onNotFound,
    required T Function() onUsersList,
    required T Function(int) onUserDetails,
    required T Function(int) onPostsList,
    required T Function(int) onPostDetails,
    required T Function(int) onAlbumsList,
    required T Function(int) onAlbumDetails
  }) {
    return onPostDetails.call(postId);
  }

  @override
  T maybeWhen<T extends Object?>({
    T Function()? onNotFound,
    T Function()? onUsersList,
    T Function(int)? onUserDetails,
    T Function(int)? onPostsList,
    T Function(int)? onPostDetails,
    T Function(int)? onAlbumsList,
    T Function(int)? onAlbumDetails,
    required T orElse()
  }) {
    if (onPostDetails != null) return onPostDetails.call(postId);
    else return orElse();
  }
}

abstract class MainNavigationStackItemPostDetails implements MainNavigationStackItem{
  const factory MainNavigationStackItemPostDetails({required int postId})
      = _MainNavigationStackItemPostDetails;

  int get postId => throw UnimplementedError();
}

/*
    Albums List
*/

class _MainNavigationStackItemAlbumsList implements MainNavigationStackItemAlbumsList {
  const _MainNavigationStackItemAlbumsList({required this.userId});

  @override
  final int userId;

  @override
  T when<T extends Object?>({
    required T Function() onNotFound,
    required T Function() onUsersList,
    required T Function(int) onUserDetails,
    required T Function(int) onPostsList,
    required T Function(int) onPostDetails,
    required T Function(int) onAlbumsList,
    required T Function(int) onAlbumDetails
  }) {
    return onAlbumsList.call(userId);
  }

  @override
  T maybeWhen<T extends Object?>({
    T Function()? onNotFound,
    T Function()? onUsersList,
    T Function(int)? onUserDetails,
    T Function(int)? onPostsList,
    T Function(int)? onPostDetails,
    T Function(int)? onAlbumsList,
    T Function(int)? onAlbumDetails,
    required T orElse()
  }) {
    if (onAlbumsList != null) return onAlbumsList.call(userId);
    else return orElse();
  }
}

abstract class MainNavigationStackItemAlbumsList implements MainNavigationStackItem{
  const factory MainNavigationStackItemAlbumsList({required int userId})
      = _MainNavigationStackItemAlbumsList;

  int get userId => throw UnimplementedError();
}

/*
    Album Details
*/

class _MainNavigationStackItemAlbumDetails implements MainNavigationStackItemAlbumDetails {
  const _MainNavigationStackItemAlbumDetails({required this.albumId});

  @override
  final int albumId;

  @override
  T when<T extends Object?>({
    required T Function() onNotFound,
    required T Function() onUsersList,
    required T Function(int) onUserDetails,
    required T Function(int) onPostsList,
    required T Function(int) onPostDetails,
    required T Function(int) onAlbumsList,
    required T Function(int) onAlbumDetails
  }) {
    return onAlbumDetails.call(albumId);
  }

  @override
  T maybeWhen<T extends Object?>({
    T Function()? onNotFound,
    T Function()? onUsersList,
    T Function(int)? onUserDetails,
    T Function(int)? onPostsList,
    T Function(int)? onPostDetails,
    T Function(int)? onAlbumsList,
    T Function(int)? onAlbumDetails,
    required T orElse()
  }) {
    if (onAlbumDetails != null) return onAlbumDetails.call(albumId);
    else return orElse();
  }
}

abstract class MainNavigationStackItemAlbumDetails implements MainNavigationStackItem{
  const factory MainNavigationStackItemAlbumDetails({required int albumId})
      = _MainNavigationStackItemAlbumDetails;

  int get albumId => throw UnimplementedError();
}