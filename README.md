# ElasticListView

## Description

`ElasticListView` is a drop-in replacement for Flutter's `ListView`, providing an elastic overscroll effect. It adds the `.builder` and `.separated` constructors as well as the standard `ListView` constructor. To migrate to `ElasticListView`, simply add the `Elastic` prefix to any existing `ListView` widget.

https://github.com/monster555/flutter_elastic_list_view/assets/32662133/bbcdc225-b046-4924-af0b-2d80643988f2

## Features

- **Elastic Overscroll Effect**: `ElasticListView` enhances the user experience by providing an elastic overscroll effect.
- **Drag to Scroll**: Adds the drag to scroll behavior by default, providing a smooth scrolling experience. This can be disabled by setting the `enableDragScrolling` property to false.
- **Optimized Performance**: Leverages the performance optimizations of the standard `ListView`, ensuring excellent performance.

## Extended Functionality with Full Compatibility

`ElasticListView` maintains the exact same properties as the standard `ListView`, ensuring full compatibility and making it a seamless replacement. In addition, it introduces new properties to control the elastic effect, offering enhanced functionality and customization options beyond the standard `ListView`.

## New Properties

Here are the new properties introduced by `ElasticListView`:

- `curve`: The curve to apply when animating the elastic effect. Defaults to `Curves.easeOut`.
- `animationDuration`: The duration of the overscroll bounce animation. Defaults to `Duration(milliseconds: 200)`.
- `enableDragScrolling`: Whether to enable drag scrolling. Defaults to `true`.
- `elasticityFactor`: The factor by which the scroll view overscrolls. Defaults to `4`.

Each of these properties allows you to customize the behavior of the elastic effect in `ElasticListView`.

## Usage

To use `ElasticListView`, simply replace your existing `ListView` with `ElasticListView`. All the properties are the same, ensuring full compatibility.

For `ListView`:

```dart
ElasticListView(
  children: <Widget>[
    ListTile(
      leading: Icon(Icons.map),
      title: Text('Map'),
    ),
    ListTile(
      leading: Icon(Icons.photo_album),
      title: Text('Album'),
    ),
    ListTile(
      leading: Icon(Icons.phone),
      title: Text('Phone'),
    ),
  ],
)
```

For `ListView.builder`:

```dart
ElasticListView.builder(
  itemCount: 10,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item $index'),
    );
  },
)
```

And for `ListView.separated`:

```dart
ElasticListView.separated(
  itemCount: 10,
  separatorBuilder: (BuildContext context, int index) => Divider(),
  itemBuilder: (BuildContext context, int index) {
    return ListTile(
      title: Text('Item $index'),
    );
  },
)
```
## Contribution
Contributions are welcome! If you encounter any issues or have suggestions for improvements, please feel free to create a pull request.
