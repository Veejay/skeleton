# Skeleton

This code should be the basis for some of the most byzantine methods in `versions.rb`.
## Intended use
```ruby
  # Where the skeleton is readable
  @skeleton = Skeleton.new skeleton
  widgets.each do |widget|
    ...
    @skeleton.replace widget: old_id, by: new_id
  end
  @version.set skeleton: skeleton.to_hash
```
## TODO

- Clean up `require`s, `extend`s and `include`s
- ~~Remove the code to read the skeleton from a file, the skeleton will be readily available in real life~~
- ~~The code for the different `widgets` methods in a few of the classes is heavily repetitive. Seems ripe for refactoring~~
- ~~In a few of the `initialize` methods, we mutate things, no need for that~~
- ~~Class `Row` is on the ugly side. The `initialize` method is too long for what it does and the `subrow?` and `widget?` methods are not used anywhere.~~
