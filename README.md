# ElasticListView

## Description

`ElasticListView` is a drop-in replacement for Flutter's `ListView.builder`, providing an elastic overscroll effect.


https://github.com/monster555/flutter_elastic_list_view/assets/32662133/d0590ae7-8170-4036-9ced-da7b9c0bda8e


## Features

- **Elastic Overscroll Effect**: `ElasticListView` enhances the user experience by providing an elastic overscroll effect.
- **Drag to Scroll**: Adds the drag to scroll behavior by default, providing a smooth scrolling experience. This can be disabled by setting the `enableDragScrolling` property to false.
- **Optimized Performance**: Leverages the performance optimizations of the standard `ListView.builder`, ensuring excellent performance.

## Extended Functionality with Full Compatibility

`ElasticListView` maintains the exact same properties as the standard `ListView.builder`, ensuring full compatibility and making it a seamless replacement. In addition, it introduces new properties to control the elastic effect, offering enhanced functionality and customization options beyond the standard `ListView.builder`.

## New Properties

Here are the new properties introduced by `ElasticListView`:

- `curve`: The curve to apply when animating the elastic effect. Defaults to `Curves.easeOut`.
- `animationDuration`: The duration of the overscroll bounce animation. Defaults to `Duration(milliseconds: 200)`.
- `enableDragScrolling`: Whether to enable drag scrolling. Defaults to `true`.
- `elasticityFactor`: The factor by which the scroll view overscrolls. Defaults to `4`.

Each of these properties allows you to customize the behavior of the elastic effect in `ElasticListView`.


## Usage

To use `ElasticListView`, simply replace your existing `ListView.builder` with `ElasticListView`. All the properties are the same, ensuring full compatibility.

```dart
ElasticListView(
  itemCount: 10,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item $index'),
    );
  },
)
```


## Contribution
Contributions are welcome! If you encounter any issues or have suggestions for improvements, please feel free to create a pull request.
