import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// listen 1
class ValueListenableBuilder1<A> extends StatelessWidget {
  const ValueListenableBuilder1({
    required this.first,
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> first;
  final Widget? child;
  final Widget Function(
    BuildContext context,
    A a,
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
        valueListenable: first,
        builder: (_, a, __) => builder(context, a, child),
      );
}

// listen 2
class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    required this.first,
    required this.second,
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget? child;
  final Widget Function(
    BuildContext context,
    A a,
    B b,
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
        valueListenable: first,
        builder: (_, a, __) => ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, b, __) => builder(context, a, b, child),
        ),
      );
}

// listen 6
class ValueListenableBuilder6<A, B, C, D, E, F> extends StatelessWidget {
  const ValueListenableBuilder6({
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.sixth,
    required this.builder,
    Key? key,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final ValueListenable<C> third;
  final ValueListenable<D> fourth;
  final ValueListenable<E> fifth;
  final ValueListenable<F> sixth;
  final Widget? child;
  final Widget Function(
    BuildContext context,
    A a,
    B b,
    C c,
    D d,
    E e,
    F f,
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
        valueListenable: first,
        builder: (_, a, __) => ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (_, b, __) => ValueListenableBuilder(
            valueListenable: third,
            builder: (_, c, __) => ValueListenableBuilder(
              valueListenable: fourth,
              builder: (_, d, __) => ValueListenableBuilder(
                valueListenable: fifth,
                builder: (_, e, __) => ValueListenableBuilder(
                  valueListenable: sixth,
                  builder: (context, f, _) =>
                      builder(context, a, b, c, d, e, f, child),
                ),
              ),
            ),
          ),
        ),
      );
}
