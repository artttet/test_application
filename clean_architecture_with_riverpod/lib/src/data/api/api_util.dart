import 'package:test_application/src/data/api/models/api_model_key.dart';
import 'package:test_application/src/data/api/models/api_album.dart';
import 'package:test_application/src/data/api/models/api_comment.dart';
import 'package:test_application/src/data/api/models/api_photo.dart';
import 'package:test_application/src/data/api/models/api_post.dart';
import 'package:test_application/src/data/api/models/api_user.dart';
import 'package:test_application/src/data/api/models/api_user_short.dart';
import 'package:test_application/src/data/api/services/shared_preferences_service.dart';
import 'package:test_application/src/data/api/services/typicode_service.dart';
import 'package:test_application/src/data/mappers/album_mapper.dart';
import 'package:test_application/src/data/mappers/comment_mapper.dart';
import 'package:test_application/src/data/mappers/photo_mapper.dart';
import 'package:test_application/src/data/mappers/post_mapper.dart';
import 'package:test_application/src/data/mappers/user_mapper.dart';
import 'package:test_application/src/data/mappers/user_short_mapper.dart';
import 'package:test_application/src/domain/entities/album.dart';
import 'package:test_application/src/domain/entities/comment.dart';
import 'package:test_application/src/domain/entities/photo.dart';
import 'package:test_application/src/domain/entities/post.dart';
import 'package:test_application/src/domain/entities/user.dart';
import 'package:test_application/src/domain/entities/user_short.dart';


class ApiUtil {
  final TypicodeService _typicodeService = TypicodeService();
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  Future<List<UserShort>?> getUserShortList() async {
    final modelKey = ApiModelKey(data: ApiUserShort.dataKey);
    final isSaved = await _sharedPreferencesService.getIsDataListSaved(key: modelKey);
    if (isSaved == null || isSaved == false) {
      final data = await _typicodeService.getData('users');
      
      if (data == null) {
        return null;
      }

      final userShortDataMap = <ApiModelKey, Map<String, dynamic>>{};

      final apiUserShortList = (data as List<dynamic>)
          .map((userShortData) {
            final apiUserShort = ApiUserShort.fromJson(userShortData);
            userShortDataMap[modelKey.copyWith(withId: apiUserShort.id)] = apiUserShort.toJson();
            return apiUserShort;
          })
          .toList();

      await _sharedPreferencesService.setJsonDataList(userShortDataMap);
      await _sharedPreferencesService.setIsDataListSaved(true, key: modelKey);

      return apiUserShortList
        .map((apiUserShort) => UserShortMapper.fromApi(apiUserShort))
        .toList();
    } else {
      final apiUserShortJsonList = await _sharedPreferencesService.getJsonDataList(key: modelKey);
      final apiUserShortList = apiUserShortJsonList
          .map((apiUserShortJson) => ApiUserShort.fromJson(apiUserShortJson))
          .toList();

      return apiUserShortList
        .map((apiUserShort) => UserShortMapper.fromApi(apiUserShort))
        .toList();
    }
  }

  Future<User?> getUser({required int id}) async {
    final modelKey = ApiModelKey(
      data: ApiUser.dataKey,
      withId: id
    );
    final isSaved = await _sharedPreferencesService.getIsDataSaved(key: modelKey);

    if (isSaved == null || isSaved == false) {
      final data = await _typicodeService.getData('users/$id');

      if (data == null) {
        return null;
      }

      final userData = data as Map<String, dynamic>;
      await _sharedPreferencesService.setJsonData(key: modelKey, jsonObject: userData);
      await _sharedPreferencesService.setIsDataSaved(true, key: modelKey);
      final apiUser = ApiUser.fromJson(userData);
      return UserMapper.fromApi(apiUser);
    } else {
      final apiUserJson = await _sharedPreferencesService.getJsonData(key: modelKey);
      final apiUser = ApiUser.fromJson(apiUserJson!);

      return UserMapper.fromApi(apiUser);
    }
  }

  Future<Post?> getPost({required int id}) async {
    final modelKey = ApiModelKey(
      data: ApiPost.dataKey,
      withId: id
    );
    final isSaved = await _sharedPreferencesService.getIsDataSaved(key: modelKey);

    if (isSaved == null || isSaved == false) {
      final data = await _typicodeService.getData('posts/$id');

      if (data == null) {
        return null;
      }

      final postData = data as Map<String, dynamic>;
      await _sharedPreferencesService.setJsonData(key: modelKey, jsonObject: postData);
      await _sharedPreferencesService.setIsDataSaved(true, key: modelKey);
      final apiPost = ApiPost.fromJson(postData);
      return PostMapper.fromApi(apiPost);
    } else {
      final apiPostJson = await _sharedPreferencesService.getJsonData(key: modelKey);
      final apiPost = ApiPost.fromJson(apiPostJson!);

      return PostMapper.fromApi(apiPost);
    }
  }

  Future<List<Post>?> _getPostsList({required int userId}) async {
    final modelKey = ApiModelKey(
      data: ApiPost.dataKey,
      withOwnerId: userId
    );
    final isSaved = await _sharedPreferencesService.getIsDataListSaved(key: modelKey);

    if (isSaved == null || isSaved == false) {
      final data = await _typicodeService.getData('posts',
        queryParameters: {'userId': userId}
      );

      if (data == null) {
        return null;
      }

      final postDataMap = <ApiModelKey, Map<String, dynamic>>{};

      final apiPostsList = (data as List<dynamic>)
          .getRange(3, data.length)
          .map((postData) {
            final apiPost = ApiPost.fromJson(postData);
            postDataMap[modelKey.copyWith(withId: apiPost.id)] = apiPost.toJson();
            return apiPost;
          })
          .toList();

      await _sharedPreferencesService.setJsonDataList(postDataMap);
      await _sharedPreferencesService.setIsDataListSaved(true, key: modelKey);

      return apiPostsList
        .map((apiPost) => PostMapper.fromApi(apiPost))
        .toList();
    } else {
      final apiPostJsonList = await _sharedPreferencesService.getJsonDataList(key: modelKey);
      final apiPostsList = apiPostJsonList
          .map((apiPostJson) => ApiPost.fromJson(apiPostJson))
          .toList();

      return apiPostsList
        .map((apiPost) => PostMapper.fromApi(apiPost))
        .toList();
    }
  }

  Future<List<Post>?> _getPreviewPostList({required int userId}) async {
    final modelKey = ApiModelKey(
      data: ApiPost.dataPreviewKey,
      withOwnerId: userId
    );
    final isSaved = await _sharedPreferencesService.getIsDataListSaved(key: modelKey);

    if (isSaved == null || isSaved == false) {
      final data = await _typicodeService.getData('posts',
        queryParameters: {'userId': userId}
      );

      if (data == null) {
        return null;
      }

      final postDataMap = <ApiModelKey, Map<String, dynamic>>{};

      final apiPostsList = (data as List<dynamic>)
          .getRange(0, 3)
          .map((postData) {
            final apiPost = ApiPost.fromJson(postData);
            postDataMap[modelKey.copyWith(withId: apiPost.id)] = apiPost.toJson();
            return apiPost;
          })
          .toList();

      await _sharedPreferencesService.setJsonDataList(postDataMap);
      await _sharedPreferencesService.setIsDataListSaved(true, key: modelKey);

      return apiPostsList
        .map((apiPost) => PostMapper.fromApi(apiPost))
        .toList();
    } else {
      final apiPostJsonList = await _sharedPreferencesService.getJsonDataList(key: modelKey);
      final apiPostsList = apiPostJsonList
          .map((apiPostJson) => ApiPost.fromJson(apiPostJson))
          .toList();

      return apiPostsList
        .map((apiPost) => PostMapper.fromApi(apiPost))
        .toList();
    }
  }

  Future<List<Post>?> getPostsList({required int userId, required bool isPreview}) async {
    List<Post>? postsList = await _getPreviewPostList(userId: userId);

    if (postsList == null) {
      return null;
    }

    if (!isPreview) {
      final list = await _getPostsList(userId: userId);
      if (list != null) {
        postsList.addAll(list);
      } else return null;
    }
    return postsList;
  }

  Future<List<Album>?> _getAlbumsList({required int userId}) async {
    final modelKey = ApiModelKey(
      data: ApiAlbum.dataKey,
      withOwnerId: userId
    );
    final isSaved = await _sharedPreferencesService.getIsDataListSaved(key: modelKey);
    if (isSaved == null || isSaved == false) {
    final data = await _typicodeService.getData('albums',
        queryParameters: {'userId': userId}
      );

      if (data == null) {
        return null;
      }

      final albumsDataMap = <ApiModelKey, Map<String, dynamic>>{};
      final apiAlbumsList = (data as List<dynamic>)
          .getRange(3, data.length)
          .map((albumData) {
            final apiAlbum = ApiAlbum.fromJson(albumData);
            albumsDataMap[modelKey.copyWith(withId: apiAlbum.id)] = apiAlbum.toJson();
            return apiAlbum;
          })
          .toList();

      await _sharedPreferencesService.setJsonDataList(albumsDataMap);
      await _sharedPreferencesService.setIsDataListSaved(true, key: modelKey);

      return apiAlbumsList
        .map((apiAlbum) => AlbumMapper.fromApi(apiAlbum))
        .toList();
    } else {
      final apiAlbumJsonList = await _sharedPreferencesService.getJsonDataList(key: modelKey);
      final apiAlbumsList = apiAlbumJsonList
          .map((apiAlbumJson) => ApiAlbum.fromJson(apiAlbumJson))
          .toList();

      return apiAlbumsList
        .map((apiAlbum) => AlbumMapper.fromApi(apiAlbum))
        .toList();
    }
  }

  Future<List<Album>?> _getPreviewAlbumsList({required int userId}) async {
    final modelKey = ApiModelKey(
      data: ApiAlbum.dataPreviewKey,
      withOwnerId: userId
    );
    final isSaved = await _sharedPreferencesService.getIsDataListSaved(key: modelKey);
    if (isSaved == null || isSaved == false) {
    final data = await _typicodeService.getData('albums',
        queryParameters: {'userId': userId}
      );

      if (data == null) {
        return null;
      }

      final albumsDataMap = <ApiModelKey, Map<String, dynamic>>{};
      final apiAlbumsList = (data as List<dynamic>)
          .getRange(0, 3)
          .map((albumData) {
            final apiAlbum = ApiAlbum.fromJson(albumData);
            albumsDataMap[modelKey.copyWith(withId: apiAlbum.id)] = apiAlbum.toJson();
            return apiAlbum;
          })
          .toList();

      await _sharedPreferencesService.setJsonDataList(albumsDataMap);
      await _sharedPreferencesService.setIsDataListSaved(true, key: modelKey);

      return apiAlbumsList
        .map((apiAlbum) => AlbumMapper.fromApi(apiAlbum))
        .toList();
    } else {
      final apiAlbumJsonList = await _sharedPreferencesService.getJsonDataList(key: modelKey);
      final apiAlbumsList = apiAlbumJsonList
          .map((apiAlbumJson) => ApiAlbum.fromJson(apiAlbumJson))
          .toList();

      return apiAlbumsList
        .map((apiAlbum) => AlbumMapper.fromApi(apiAlbum))
        .toList();
    }
  }

  Future<List<Album>?> getAlbumsList({required int userId, required bool isPreview}) async {
    List<Album>? albumsList = await _getPreviewAlbumsList(userId: userId);

    if (albumsList == null) {
      return null;
    }

    if (!isPreview) {
      final list = await _getAlbumsList(userId: userId);
      if (list != null) {
        albumsList.addAll(list);
      } else return null;
    }

    return albumsList;
  }

  Future<Photo?> getFirstPhoto({required int albumId}) async {
    final modelKey = ApiModelKey(
      data: ApiPhoto.firstDataKey,
      withOwnerId: albumId
    );
    final isSaved = await _sharedPreferencesService.getIsDataSaved(key: modelKey);

    if (isSaved == null || isSaved == false) {
      final data = await _typicodeService.getData('photos',
        queryParameters: {'albumId': albumId}
      );

      if (data == null) {
        return null;
      }

      final photosData = data as List<dynamic>;
      final firstPhotoData = photosData.first;
      final apiPhoto = ApiPhoto.fromJson(firstPhotoData);

      await _sharedPreferencesService.setJsonData(
        key: modelKey,
        jsonObject: apiPhoto.toJson()
      );
      await _sharedPreferencesService.setIsDataSaved(true, key: modelKey);

      return PhotoMapper.fromApi(apiPhoto);
    } else {
      final apiPhotoJson = await _sharedPreferencesService.getJsonData(key: modelKey);
      final apiPhoto = ApiPhoto.fromJson(apiPhotoJson!);

      return PhotoMapper.fromApi(apiPhoto);
    }
  }

  Future<List<Photo>?> getPhotosList({required int albumId}) async {
    final modelKey = ApiModelKey(
      data: ApiPhoto.dataKey,
      withOwnerId: albumId
    );
    final isSaved = await _sharedPreferencesService.getIsDataListSaved(key: modelKey);

    if (isSaved == null || isSaved == false) {
      final data = await _typicodeService.getData('photos',
        queryParameters: {'albumId': albumId}
      );

      if (data == null) {
        return null;
      }

      final photosDataMap = <ApiModelKey, Map<String, dynamic>>{};

      final apiPhotosList = (data as List<dynamic>)
          .map((photoData) {
            final apiPhoto = ApiPhoto.fromJson(photoData);
            photosDataMap[modelKey.copyWith(withId: apiPhoto.id)] = apiPhoto.toJson();
            return apiPhoto;
          })
          .toList();

      await _sharedPreferencesService.setJsonDataList(photosDataMap);
      await _sharedPreferencesService.setIsDataListSaved(true, key: modelKey);

      return apiPhotosList
        .map((apiPhoto) => PhotoMapper.fromApi(apiPhoto))
        .toList();
    } else {
      final apiPhotoJsonList = await _sharedPreferencesService.getJsonDataList(key: modelKey);
      final apiPhotosList = apiPhotoJsonList
          .map((apiPhotoJson) => ApiPhoto.fromJson(apiPhotoJson))
          .toList();

      return apiPhotosList
        .map((apiPhoto) => PhotoMapper.fromApi(apiPhoto))
        .toList();
    }
  }

  Future<List<Comment>?> getCommentsList({required postId}) async {
    final modelKey = ApiModelKey(
      data: ApiComment.dataKey,
      withOwnerId: postId
    );
    final isSaved = await _sharedPreferencesService.getIsDataListSaved(key: modelKey);

    if (isSaved == null || isSaved == false) {
      final data = await _typicodeService.getData('comments',
        queryParameters: {'postId': postId}
      );

      if (data == null) {
        return null;
      }

      final commentsDataMap = <ApiModelKey, Map<String, dynamic>>{};

      final apiCommentsList = (data as List<dynamic>)
          .map((commentData) {
            final apiComment = ApiComment.fromJson(commentData);
            commentsDataMap[modelKey.copyWith(withId: apiComment.id)] = apiComment.toJson();
            return apiComment;
          })
          .toList();

      await _sharedPreferencesService.setJsonDataList(commentsDataMap);
      await _sharedPreferencesService.setIsDataListSaved(true, key: modelKey);

      return apiCommentsList
        .map((apiComment) => CommentMapper.fromApi(apiComment))
        .toList();
    } else {
      final apiCommentJsonList = await _sharedPreferencesService.getJsonDataList(key: modelKey);
      final apiCommentsList = apiCommentJsonList
          .map((apiCommentJson) => ApiComment.fromJson(apiCommentJson))
          .toList();

      return apiCommentsList
        .map((apiComment) => CommentMapper.fromApi(apiComment))
        .toList();
    }
  }

  Future<Comment?> addComment({required Comment comment}) async {
    final apiComment = CommentMapper.fromEntity(comment);
    final data = await _typicodeService.postData('comments',
      data: apiComment.toJson()
    );

    if (data == null) {
      return null;
    }

    final newApiComment = ApiComment.fromJson((data as Map<String, dynamic>));
    final modelKey = ApiModelKey(
      data: ApiComment.dataKey,
      withId: newApiComment.id,
      withOwnerId: newApiComment.postId
    );

    await _sharedPreferencesService.setJsonData(key: modelKey, jsonObject: newApiComment.toJson());
    await _sharedPreferencesService.setIsDataSaved(true, key: modelKey);

    return CommentMapper.fromApi(newApiComment);
  }
}