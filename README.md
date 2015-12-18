# Skeleton

This code should be the basis for some of the most byzantine methods in `versions.rb`.

## TODO

- Remove the code to read the skeleton from a file, the skeleton will be readily available in real life
- The code for the different `widgets` methods in a few of the classes is heavily repetitive. Seems ripe for refactoring
- In a few of the `initialize` methods, we mutate things, no need for that
- Class `Row` is on the ugly side. The `initialize` method is too long for what it does and the `subrow?` and `widget?` methods are not used anywhere.
- It's possible that a few of the operation can be made concurrently (the `to_hash` and `widgets` come to mind), which could help performance for bigger skeletons
