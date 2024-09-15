
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:snippet/common/border_radius.dart';
import 'package:snippet/domain/models/search_response_list.dart';
import 'package:snippet/ui/snippet_dialog/upload_snippet_dialog_controller.dart';

class ViewSnippetDialog extends StatelessWidget {
  const ViewSnippetDialog({super.key,required this.snippetData});

  final SearchResponseList snippetData;
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(snippetData.title??'',
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 32,),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: AppBorderRadius.k8px,
            ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: snippetData.snippet ?? ''));
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  snippetData.snippet ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          )


          )]
          ),
        ));


  }
}
