import 'dart:io';
import 'package:flutter/material.dart';
import 'package:madrasah_app/state_management/file_attach_state.dart';
import 'package:madrasah_app/state_management/storage_state.dart';
import 'package:madrasah_app/utils/form_validation.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/shared_widgets/input_field.dart';
import 'package:madrasah_app/views/styles/dimentions.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import 'package:provider/provider.dart';

class AddNoticeScreen extends StatefulWidget {
  AddNoticeScreen({Key? key}) : super(key: key);

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController decribtionController = TextEditingController();

  final fromKey = GlobalKey<FormState>();

  final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10)));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<StorageState>(context, listen: false).gotoInitial();
      Provider.of<FileAttechState>(context, listen: false).clearLisr();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<StorageState>(context, listen: false).gotoInitial();
    Provider.of<FileAttechState>(context, listen: false).clearLisr();
  }

  @override
  Widget build(BuildContext context) {
    var storageProvider = Provider.of<StorageState>(context);
    var storageProviderMuted =
        Provider.of<StorageState>(context, listen: false);
    var attachFileState = Provider.of<FileAttechState>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              // vertical: size(context).height * 0.1,
              right: size(context).width * 0.1,
              left: size(context).width * 0.1,
              top: size(context).width * 0.1),
          child: SingleChildScrollView(
            child: Form(
              key: fromKey,
              child: Column(
                children: [
                  InputField(
                    hintText: 'Enter notice title here',
                    validator: FormValidation.validateNoticeTitle,
                    textEditingController: titleController,
                    maxLength: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: decribtionController,
                    maxLines: 4,
                    cursorColor: CResources.black,
                    style: TextStyle(
                        color: CResources.black, fontFamily: Fonts.openSans),
                    decoration: InputDecoration(
                        hintText: 'Enter notice desctribtion(Optional)',
                        enabledBorder: border,
                        focusedBorder: border,
                        errorBorder: border,
                        focusedErrorBorder: border,
                        hintStyle: TextStyle(
                          color: CResources.black,
                        ),
                        fillColor: CResources.black.withOpacity(0.1),
                        filled: true),
                  ),
                  GestureDetector(
                    onTap: Provider.of<FileAttechState>(context)
                            .attachedFiles
                            .isEmpty
                        ? () async {
                            Provider.of<FileAttechState>(context, listen: false)
                                .pickFiels();
                          }
                        : null,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      height: size(context).height * 0.3,
                      width: double.infinity,
                      child: Provider.of<FileAttechState>(context)
                              .attachedFiles
                              .isEmpty
                          ? Center(
                              child: Text(
                              'Click here to attach some files',
                              style: TextStyle(fontFamily: Fonts.monserrat),
                            ))
                          : AttachedFileList(
                              attachedFile: Provider.of<FileAttechState>(
                                      context,
                                      listen: false)
                                  .attachedFiles,
                            ),
                      decoration: BoxDecoration(
                          color: CResources.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  storageProvider.upLoadPersent != 100.0 &&
                          storageProvider.isLoading
                      ? Text(
                          'Uploading ${storageProvider.upLoadPersent}%, don\'t close the window')
                      : Container(),
                  Button(
                    buttonText: storageProvider.isDone ||
                            attachFileState.attachedFiles.isEmpty
                        ? 'Post the notice'
                        : 'Upload assets',
                    onPressed: storageProvider.isLoading
                        ? null
                        : storageProvider.isDone ||
                                attachFileState.attachedFiles.isEmpty
                            ? () {}
                            : () {
                                if (fromKey.currentState!.validate()) {
                                  print('Form is valid');
                                  if (attachFileState
                                      .attachedFiles.isNotEmpty) {
                                    storageProviderMuted.uploadMultipleFile(
                                        attachFileState.attachedFiles);
                                  }
                                }
                              },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  const Button({Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: Align(
        alignment: Alignment.bottomRight,
        child: MaterialButton(
          onPressed: onPressed,
          color: CResources.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(
            buttonText,
            style: TextStyle(color: CResources.white),
          ),
        ),
      ),
    );
  }
}

class AttachedFileList extends StatelessWidget {
  final List<File> attachedFile;
  const AttachedFileList({Key? key, required this.attachedFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: attachedFile.length,
                // shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                      title: Text(
                        attachedFile[index].path.split('/').last,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Provider.of<FileAttechState>(context, listen: false)
                              .removeAItem(index);
                        },
                        icon: Icon(
                          Icons.close,
                          color: CResources.red,
                        ),
                      ),
                    )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              height: 30,
              minWidth: double.infinity,
              color: CResources.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: Provider.of<StorageState>(context).isLoading
                  ? null
                  : () {
                      Provider.of<FileAttechState>(context, listen: false)
                          .pickFiels();
                    },
              child: Text(
                'Add more',
                style: TextStyle(color: CResources.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
