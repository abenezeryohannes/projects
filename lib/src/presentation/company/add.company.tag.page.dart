import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linko/injectable/getit.dart';
import 'package:linko/src/domain/company/entities/tag.entity.dart';
import 'package:linko/src/domain/company/usecases/find.tag.usecase.dart';
import '../../appcore/widgets/big.text.button.dart';
import '../../appcore/widgets/editable.tag.dart';
import '../../appcore/widgets/loading.bar.dart';
import '../../infrastructure/company/dto/tag.dto.dart';

class AddCompanyTagPage extends StatefulWidget {
  const AddCompanyTagPage({super.key, required this.tagsDto});

  final List<TagDto> tagsDto;
  // final Function(List<TagDto>) onSelect;
  @override
  State<AddCompanyTagPage> createState() => _AddCompanyTagPageState();
}

class _AddCompanyTagPageState extends State<AddCompanyTagPage> {
  late List<TagDto> tags;
  late List<String> types;
  bool loading = false;
  List<TagEntity> tagEntities = [];

  @override
  void initState() {
    tags = widget.tagsDto;
    findTags();
    super.initState();
  }

  Future findTags({String? search}) async {
    final result = await getIt<FindTagUsecase>()(
        param: FindTagUsecaseParam(search: search));

    if (result != null) {
      result.fold((l) {
        print('loading tag error ${l.message}');
      }, (r) {
        setState(() {
          tagEntities = r.datas ?? [];
          types = getTypes(r.datas ?? []);
        });
      });
    }
  }

  List<String> getTypes(List<TagEntity> te) {
    List<String> result = [];
    for (var element in te) {
      if (element.type != null &&
          !result.contains(element.type?.toLowerCase())) {
        result.add(element.type!.toLowerCase());
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...childrens()],
            ),
          ),
        ),
      ),
    );
    // return Dialog(
    //     shape: const RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(20.0))),
    //     child: Material(
    //         borderRadius: const BorderRadius.all(Radius.circular(50)),
    //         color: Colors.transparent,
    //         child: Container(
    //             decoration: BoxDecoration(
    //                 color: Theme.of(context).scaffoldBackgroundColor,
    //                 borderRadius: const BorderRadius.all(Radius.circular(50))),
    //             child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [...childrens()]))));
  }

  List<Widget> childrens() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingBar(
              padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
              show: loading),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
            child: EditableTag(
              suggestions: tagEntities,
              placeholder: ('add_tags').tr,
              onSelected: (val) {
                if (!tags.contains(TagDto(name: val))) {
                  setState(() {
                    tags.add(TagDto(name: val));
                  });
                }
              },
              searchOption: (val) {
                findTags(search: val);
              },
              tags: tags.map((e) => e.name).toList(),
              validator: (x) => (x == null || ((x.length) < 4))
                  ? 'Tag must be at least more th)atn 3 character'
                  : null,
              onTagDelete: (tag) {
                setState(() {
                  tags.removeWhere((element) =>
                      element.name.toLowerCase().startsWith(tag.toLowerCase()));
                });
              },
            ),
          ),
          if (tagEntities.isNotEmpty)
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: types.length,
                itemBuilder: (context, index) {
                  final results = tagEntities.where((element) =>
                      element.type != null &&
                      element.type!.toLowerCase() == (types[index]));

                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10.0, left: 5, top: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Text(types[index].toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Wrap(
                              spacing: 3,
                              runSpacing: 5,
                              alignment: WrapAlignment.center,
                              runAlignment: WrapAlignment.center,
                              direction: Axis.horizontal,
                              children: results.map((TagEntity tag) {
                                return _tag(tag.name, context);
                              }).toList()),
                        ),
                      ],
                    ),
                  );
                })
        ],
      ),
      Padding(
        padding:
            const EdgeInsets.only(left: 30.0, right: 30, bottom: 50, top: 30),
        child: BigTextButton(
          borderColor: Theme.of(context).colorScheme.secondary,
          backgroudColor: Theme.of(context).colorScheme.secondary,
          enabled: true,
          onClick: () {
            // Navigator.maybePop<List<TagDto>>(context, tags);
            Get.back<List<TagDto>>(result: tags);
          },
          text: ('save').tr,
          padding: const EdgeInsets.symmetric(vertical: 16),
          cornerRadius: 30,
        ),
      )
    ];
  }

  Widget _tag(String tag, BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          tags.add(TagDto(name: tag));
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: Theme.of(context).cardColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '#${tag.capitalizeFirst ?? ''}',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(width: 4.0),
            // InkWell(
            //   child: Icon(Icons.cancel,
            //       size: 14.0,
            //       color: Theme.of(context).colorScheme.onBackground),
            //   onTap: () {
            //     tags.removeWhere(
            //         (element) => element.name.toLowerCase().contains(tag));
            //   },
            // )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: RotatedBox(
          quarterTurns:
              (Get.locale == null || Get.locale!.languageCode.contains('en'))
                  ? 3
                  : 1,
          child: Icon(
            Icons.chevron_left,
            size: 42,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ),
      title: Text(
        ('add_tags').tr,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }
}
