import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile/Components/CustomAppBar.dart';
import 'package:mobile/Models/Tour.dart';
import 'package:mobile/Network/Api.dart';
import 'package:mobile/Screens/CommentScreen.dart';
import 'package:mobile/Screens/SearchScreen.dart';
import 'package:mobile/Screens/TourBookingScreen.dart';
import 'package:mobile/Utils/Constants.dart';
import 'package:mobile/main.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'PostScreen.dart';
import 'package:http/http.dart' as http;

Color mBackgroundColor = Color(0xFFFEFEFE);

Color mPrimaryColor = Color(0xFFf36f7c);

Color mSecondaryColor = Color(0xFFfff2f3);

class DetailedTourScreen extends StatefulWidget {
  final int tourId;

  DetailedTourScreen(@required this.tourId);

  @override
  _DetailedTourScreenState createState() => _DetailedTourScreenState();
}

class _DetailedTourScreenState extends State<DetailedTourScreen> {
  final double rating = 5;

  // final String product="images/04.jpg";

  Tour tour;

  @override
  void initState() {
    super.initState();
    Api.fetchTour(widget.tourId).then((value) {
      setState(() {
        tour = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (tour == null)
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    else
      return Scaffold(
        appBar: CustomAppBar(context, "Chi tiết tour", true),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImages(tour),
              PlaceAndName(tour),
              SizedBox(
                height: 36,
              ),
              About(tour),
              Attrabute(tour),
              BookNowButton(tour),
            ],
          ),
        ),
      );
  }

}

class About extends StatelessWidget {
  final Tour tour;
  List<Widget> textWidgetList = List<Widget>();

  About(@required this.tour,);

  @override
  Widget build(BuildContext context) {
    int legth;
    if (tour == null) {
      legth = 0;
    } else {
      legth = tour.scheduleEntities.length;
    }
    for (int i = 0; i < legth; i++) {
      textWidgetList.add(
        Container(
          child: Align(
            alignment: Alignment.topLeft,
              heightFactor: 2,
              child: Wrap(
                spacing: 20, // to apply margin in the main axis of the wrap
                runSpacing: 20,
                children: [
                  Text(tour.scheduleEntities[i].time.substring(0, 10)+":"),
                  Text(tour.scheduleEntities[i].place.toUpperCase()),
                ],
              ),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Giới thiệu",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ReadMoreText(
              tour == null ? 'Loading...' : tour.description,
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: '...Xem thêm',
              trimExpandedText: ' Ẩn',
            ),
          ),
          Text(
            "Lịch trình",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: textWidgetList,
                ),
              )),
        ],
      ),
    );
  }
}

class PlaceAndName extends StatelessWidget {
  final Tour tour;

  const PlaceAndName(@required this.tour,);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        top: 12,
        bottom: 24,
      ),
      decoration: BoxDecoration(
          color: mSecondaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(36),
            bottomRight: Radius.circular(36),
          )),
      child: Wrap(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                tour == null ? 'Loading...' : tour.name,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.left,
                // maxLines: 1,
                // softWrap: false,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                tour == null ? 'Loading...' : tour.province,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [WebsafeSvg.asset('images/star.svg'), Text('4.8')],
              ),
              SizedBox(height: 10),
              Text(
                '${Constants.oCcy.format(tour.priceEntities[0].price)}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Attrabute extends StatelessWidget {
  final Tour tour;

  const Attrabute(@required this.tour,);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AttrabuteItem(
            iconUrl: 'images/mark.svg',
            isSelect: true,
          ),
          AttrabuteItem(
            iconUrl: 'images/compass.svg',
          ),
          AttrabuteItem(
            iconUrl: 'images/hotel.svg',
          ),
          AttrabuteItem(
            iconUrl: 'images/travel.svg',
          ),
          AttrabuteItem(
            iconUrl: 'images/share.svg',
          )
        ],
      ),
    );
  }
}

class AttrabuteItem extends StatelessWidget {
  final String iconUrl;
  final bool isSelect;
  final Tour tour;

  const AttrabuteItem({
    this.iconUrl,
    this.isSelect = false,
    @required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelect ? mPrimaryColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          isSelect
              ? BoxShadow()
              : BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(
        iconUrl,
        color: isSelect ? Colors.white : mPrimaryColor,
      ),
    );
  }
}

class BookNowButton extends StatelessWidget {
  final Tour tour;

  const BookNowButton(@required this.tour,);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: FlatButton(
        color: mPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TourBookingScreen(tour.id),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Text(
            'Đặt ngay',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
//
// class CustomAppBar extends PreferredSize {
//   final double rating;
//
//   CustomAppBar({@required this.rating});
//
//   @override
//   // AppBar().preferredSize.height provide us the height that appy on our app bar
//   Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Row(
//           children: [
//             SizedBox(
//               height: 40,
//               width: 40,
//               child: FlatButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(60),
//                 ),
//                 color: Colors.white,
//                 padding: EdgeInsets.zero,
//                 onPressed: () => Navigator.pop(context),
//                 child: WebsafeSvg.asset(
//                   "images/Back ICon.svg",
//                   height: 15,
//                 ),
//               ),
//             ),
//             Spacer(),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Row(
//                 children: [
//                   Text(
//                     "$rating",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   WebsafeSvg.asset("image/star.svg"),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

enum TrimMode {
  Length,
  Line,
}

class ReadMoreText extends StatefulWidget {
  const ReadMoreText(this.data, {
    Key key,
    this.trimExpandedText = ' read less',
    this.trimCollapsedText = ' ...read more',
    this.colorClickableText,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimMode.Length,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.semanticsLabel,
  })
      : assert(data != null),
        super(key: key);

  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color colorClickableText;
  final int trimLength;
  final int trimLines;
  final TrimMode trimMode;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final double textScaleFactor;
  final String semanticsLabel;

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle effectiveTextStyle = widget.style;
    if (widget.style == null || widget.style.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale =
        widget.locale ?? Localizations.localeOf(context, nullOk: true);

    final colorClickableText =
        widget.colorClickableText ?? Theme
            .of(context)
            .accentColor;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: effectiveTextStyle.copyWith(
        color: colorClickableText,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(
          style: effectiveTextStyle,
          text: widget.data,
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        print('linkSize $linkSize textSize $textSize');

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final pos = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset);
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        var textSpan;
        switch (widget.trimMode) {
          case TrimMode.Length:
            if (widget.trimLength < widget.data.length) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          case TrimMode.Line:
            if (textPainter.didExceedMaxLines) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, endIndex) +
                    (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return RichText(
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: true,
          //softWrap,
          overflow: TextOverflow.clip,
          //overflow,
          textScaleFactor: textScaleFactor,
          text: textSpan,
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}

class ProductImages extends StatefulWidget {
  ProductImages(@required this.tourImage,);

  final Tour tourImage;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 400,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.tourImage == null
                  ? 'Loading...'
                  : widget.tourImage.name,
              child: Image.network(
                  widget.tourImage.imageEntities[selectedImage].image),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.tourImage.imageEntities.length,
                    (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Color(0xFFFF7643)
                  .withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(widget.tourImage.imageEntities[index].image),
      ),
    );
  }
}
