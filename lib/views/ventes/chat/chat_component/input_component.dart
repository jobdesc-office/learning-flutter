part of '../chat.dart';

BsRow inputComponent(context) {
  return BsRow(
    margin: EdgeInsets.only(top: 10),
    children: [
      if (source.useridactive.value != 0)
        BsCol(
          margin: EdgeInsets.only(left: 5),
          sizes: ColScreen(sm: Col.col_1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ChatRef(),
                ),
                child: Icon(
                  Icons.analytics,
                  size: 32,
                ),
              ),
              InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpeg', 'jpg', 'pdf', 'png', 'gif'],
                  );
                  if (result != null) {
                    Uint8List pickedFile = result.files.single.bytes!;
                    source.pickedFile.value = pickedFile;
                    source.isFile.value = true;
                    if (result.files.single.name
                            .substring(result.files.single.name.length - 4) ==
                        '.pdf') {
                      source.isDocument.value = true;
                    }
                  }
                },
                child: Icon(
                  Icons.file_copy,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      if (source.useridactive.value != 0)
        BsCol(
          margin: EdgeInsets.only(
              left: 5,
              right:
                  text.value || source.isFile.value || source.name.value != ''
                      ? 5
                      : 20),
          sizes: ColScreen(
              sm: text.value || source.isFile.value || source.name.value != ''
                  ? Col.col_10
                  : Col.col_11),
          child: CustomInput(
            maxLines: 1,
            autofocus: true,
            controller: inputChat,
            onChange: (value) => text.value = value != '',
            onFieldSubmitted: (value) => onClickSendMessages(),
          ),
        ),
      if (text.value || source.isFile.value || source.name.value != '')
        BsCol(
          margin: EdgeInsets.only(left: 5),
          sizes: ColScreen(sm: Col.col_1),
          child: InkWell(
            onTap: () => onClickSendMessages(),
            child: CircleAvatar(
              radius: 25,
              child: Icon(Icons.send),
              backgroundColor: ColorPallates.primary,
            ),
          ),
        )
    ],
  );
}
