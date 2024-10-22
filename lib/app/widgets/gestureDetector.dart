import 'package:deening_app/app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomGestureDetectorWithFillInteraction extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Duration duration;
  final Widget child;
  final EdgeInsets effectPadding;
  final double effectBorderRadius;

  const CustomGestureDetectorWithFillInteraction({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.effectPadding = EdgeInsets.zero,
    this.effectBorderRadius = 0,
  });

  @override
  State<CustomGestureDetectorWithFillInteraction> createState() =>
      _CustomGestureDetectorWithFillInteractionState();
}

class _CustomGestureDetectorWithFillInteractionState
    extends State<CustomGestureDetectorWithFillInteraction> {
  bool isPressed = false;

  void pressUp() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = false;
    });
  }

  void pressDown() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomColors colorTheme = Theme.of(context).extension<CustomColors>()!;
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapCancel: pressUp,
      child: Listener(
        onPointerDown: (_) => pressDown(),
        onPointerUp: (_) => pressUp(),
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: isPressed ? 0.05 : 0,
                  duration: widget.duration,
                  child: Container(
                    margin: widget.effectPadding,
                    decoration: BoxDecoration(
                      color: colorTheme.contentStandardPrimary,
                      borderRadius:
                          BorderRadius.circular(widget.effectBorderRadius),
                    ),
                  ),
                ),
              ),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}

class CustomGestureDetectorWithOpacityInteraction extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Duration duration;
  final Widget child;

  const CustomGestureDetectorWithOpacityInteraction({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<CustomGestureDetectorWithOpacityInteraction> createState() =>
      _CustomGestureDetectorWithOpacityInteractionState();
}

class _CustomGestureDetectorWithOpacityInteractionState
    extends State<CustomGestureDetectorWithOpacityInteraction> {
  bool isPressed = false;

  void pressUp() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = false;
    });
  }

  void pressDown() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapCancel: pressUp,
      child: Listener(
        onPointerDown: (_) => pressDown(),
        onPointerUp: (_) => pressUp(),
        child: Container(
          color: Colors.transparent,
          child: AnimatedOpacity(
            duration: widget.duration,
            curve: Curves.easeOut,
            opacity: isPressed ? 0.6 : 1,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class CustomGestureDetectorWithScaleInteraction extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Duration duration;
  final Widget child;

  const CustomGestureDetectorWithScaleInteraction({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<CustomGestureDetectorWithScaleInteraction> createState() =>
      _CustomGestureDetectorWithScaleInteractionState();
}

class _CustomGestureDetectorWithScaleInteractionState
    extends State<CustomGestureDetectorWithScaleInteraction> {
  bool isPressed = false;

  void pressUp() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = false;
    });
  }

  void pressDown() {
    if (widget.onTap == null && widget.onLongPress == null) {
      return;
    }
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isPressed ? 0.97 : 1,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onTapCancel: pressUp,
        child: Listener(
          onPointerDown: (_) => pressDown(),
          onPointerUp: (_) => pressUp(),
          child: widget.child,
        ),
      ),
    );
  }
}
