import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/post_details/controller.dart';
import 'package:test_application/src/presentation/screens/post_details/widgets/app_text_field.dart';

class AddCommentDialog extends StatefulWidget {
  final int postId;
  AddCommentDialog({required this.postId});

  @override
  _AddCommentDialogState createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  String? name;
  String? email;
  String? body;

  @override
  Widget build(BuildContext context) {
    bool isAddButtonActive = (name != null && email != null && body != null);


    return SimpleDialog(
      title: const Text(AppStrings.addComment),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: AppTextField(
            key: ValueKey('Name Text Field (postId-${widget.postId})'),
            hintText: AppStrings.enterName,
            labelText: AppStrings.name,
            onChanged: (text) => setState(() => name = text),
            onSubmitted: (text) => setState(() => name = text),
          )
        ),
        const SizedBox(height: 12.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: AppTextField(
            key: ValueKey('Email Text Field (postId-${widget.postId})'),
            hintText: AppStrings.enterEmail,
            labelText: AppStrings.email,
            onChanged: (text) => setState(() => email = text),
            onSubmitted: (text) => setState(() => email = text),
            errorText: AppStrings.isNotEmail,
            validate: RegExp(r'\w+@\w+\.\w+'),
          )
        ),
        const SizedBox(height: 16.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: AppTextField(
            key: ValueKey('Body Text Field (postId-${widget.postId})'),
            maxLines: 4,
            hintText: AppStrings.enterText,
            labelText: AppStrings.text,
            onChanged: (text) => setState(() => body = text),
            onSubmitted: (text) => setState(() => body = text),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Consumer(
                builder: (context, watch, _) {
                  final controller = watch(postDetailsControllerProvider);

                  return MaterialButton(
                    child: const Text(AppStrings.add),
                    onPressed: !isAddButtonActive ? null
                    : () {
                      Navigator.pop(context,
                        controller.createComment(
                          postId: widget.postId,
                          name: name!,
                          email: email!,
                          body: body!
                        )
                      );
                    }
                  );
                }
              ),
              MaterialButton(
                child: const Text(AppStrings.cancel),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        )
      ],
    );
  }
}