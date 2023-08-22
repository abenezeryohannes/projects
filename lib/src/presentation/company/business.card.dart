import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linko/src/appcore/utils/utils.dart';
import 'package:linko/src/appcore/widgets/custom.shimmer.dart';
import 'package:linko/src/appcore/widgets/web.view.page.dart';
import 'package:linko/src/domain/company/entities/company.entity.dart';
import 'package:linko/src/domain/user/entities/favorites.entity.dart';
import 'package:linko/src/domain/user/usecases/find.favorite.usecase.dart';
import 'package:linko/src/domain/user/usecases/set.favorites.usecase.dart';
import 'package:linko/src/domain/user/usecases/unset.favorites.usecase.dart';
import '../../../injectable/getit.dart';
import '../../appcore/network/api.dart';
import '../../appcore/widgets/big.text.button.dart';
import '../user/favorite.identifier.dart';

import '../../appcore/widgets/text.badge.dart';

class BusinessCard extends StatefulWidget {
  const BusinessCard({super.key, this.company});
  final CompanyEntity? company;
  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  late FindFavoriteUsecase _findFavoriteUseCase;
  late SetFavoriteUsecase _setFavoriteUsecase;
  late UnsetFavoriteUsecase _removeFavoriteUseCase;
  FavoriteEntity? favoriteXO;
  int favCountToAdd = 0;
  @override
  void initState() {
    _findFavoriteUseCase = getIt<FindFavoriteUsecase>();
    _setFavoriteUsecase = getIt<SetFavoriteUsecase>();
    _removeFavoriteUseCase = getIt<UnsetFavoriteUsecase>();
    findFavorite();
    super.initState();
  }

  void findFavorite() async {
    if (widget.company == null) return;
    final result = await _findFavoriteUseCase(
        param: FindFavoriteUsecaseParam(companyID: widget.company!.id));
    result?.fold((l) {}, (r) {
      if (mounted) {
        setState(() {
          favoriteXO = r.data;
        });
      }
    });
  }

  void addFavorite(CompanyEntity? company) async {
    if (company == null) return;
    final result = await _setFavoriteUsecase(
        param: SetFavoriteUsecaseParam(company: company));
    result?.fold((l) {}, (r) {
      if (mounted) {
        setState(() {
          favoriteXO = r.data;
          favCountToAdd += 1;
        });
      }
    });
  }

  void removeFavorite(FavoriteEntity? favorite) async {
    if (favorite == null) return;
    final result = await _removeFavoriteUseCase(
        param: UnsetFavoriteUsecaseParam(favorite: favorite));
    result?.fold((l) {}, (r) {
      if (mounted) {
        setState(() {
          favoriteXO = null;
          favCountToAdd -= 1;
        });
      }
    });
  }

  void onClick() {
    if (widget.company == null || widget.company?.url == null) return;
    Get.to(() => WebViewPage(
          title: widget.company?.name,
          uri: Uri.parse(widget.company?.url ?? 'https://google.com'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
      child: InkWell(
        onTap: () {
          onClick();
        },
        focusColor: Theme.of(context).scaffoldBackgroundColor,
        hoverColor: Theme.of(context).scaffoldBackgroundColor,
        overlayColor: null,
        splashColor: Theme.of(context).scaffoldBackgroundColor,
        highlightColor: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomShimmer(
                show: widget.company == null,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(Api.getMedia(
                            widget.company?.banner ?? 'img/placeholder.png')),
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FavoriteIdentifier(
                            onClick: () {
                              if (favoriteXO == null) {
                                addFavorite(widget.company);
                              } else {
                                removeFavorite(favoriteXO);
                              }
                            },
                            fav: favoriteXO,
                            text:
                                '(${(widget.company?.liked ?? 0) + favCountToAdd})'),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 5, right: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 2),
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomShimmer(
                                show: widget.company == null,
                                child: Text(
                                  widget.company?.name ?? '-------------------',
                                  maxLines: 4,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          backgroundColor:
                                              widget.company == null
                                                  ? Colors.grey.shade100
                                                  : Colors.transparent,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              CustomShimmer(
                                show: widget.company == null,
                                child: (widget.company?.badge != null)
                                    ? TextBadge(
                                        color:
                                            (widget.company?.badgeColor != null)
                                                ? Util.HexColor(
                                                    widget.company!.badgeColor!)
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.1),
                                        text: widget.company?.badge ??
                                            '---- ----')
                                    : const SizedBox(),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            if (widget.company == null ||
                                widget.company?.deliveryTime != null)
                              CustomShimmer(
                                show: widget.company == null,
                                child: _items(
                                    text: widget.company?.deliveryTime ??
                                        '-- Min',
                                    icon: 'timer.png'),
                              ),
                            if (widget.company == null ||
                                widget.company?.deliveryTime != null)
                              const SizedBox(
                                width: 10,
                              ),
                            if (widget.company == null ||
                                widget.company?.deliveryFee != null)
                              CustomShimmer(
                                show: widget.company == null,
                                child: _items(
                                    text: widget.company?.deliveryFee ?? '-- ',
                                    icon: 'delivery_fee.png'),
                              ),
                          ],
                        )
                      ],
                    ),
                    if (widget.company == null ||
                        widget.company?.phoneNumber != null)
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: Theme(
                          data: ThemeData(primarySwatch: Colors.grey),
                          child: CustomShimmer(
                            show: widget.company == null,
                            child: BigTextButton(
                              onClick: () {
                                if (widget.company != null &&
                                    widget.company?.phoneNumber != null) {
                                  Util.dial(widget.company!.phoneNumber!);
                                }
                              },
                              text: ('call').tr,
                              textColor:
                                  Theme.of(context).colorScheme.secondary,
                              borderColor:
                                  Theme.of(context).colorScheme.secondary,
                              borderWidth: 1,
                              fontWight: FontWeight.w600,
                              elevation: 0,
                              cornerRadius: 8,
                              backgroudColor: Colors.white,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _items({required String text, required String icon}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icon/$icon',
          width: 20,
          height: 20,
          // color: Theme.of(context).highlightColor,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
