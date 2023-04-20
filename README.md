# wordle-cli

This is a Swift command line application of Wordle.

You can play this in line-mode:

```
% swift run wordle-cli --line-mode
[0/0] Build complete!
wordle-cli (by Rick Umali)
Guess (1 out of 6)? audio
1: |-A-| U | D | I |-O-|
Guess (2 out of 6)? toads
1: |-A-| U | D | I |-O-|
2: |-T-|-O-|-A-| D | S |
Guess (3 out of 6)? about
1: |-A-| U | D | I |-O-|
2: |-T-|-O-|-A-| D | S |
3: |-A-|-B-|-O-| U |-T-|
Guess (4 out of 6)? baton
1: |-A-| U | D | I |-O-|
2: |-T-|-O-|-A-| D | S |
3: |-A-|-B-|-O-| U |-T-|
4: |+B+|+A+|+T+|+O+|+N+|
Fantastic! Four guesses!
```

Or you can play this in curses mode (the default).

![wordle-puzzle-aroma](https://user-images.githubusercontent.com/40336/233233153-577ae6f3-c7af-4c94-99d9-cee25f4d4f1d.png)

This was built "live" on YouTube:

https://www.youtube.com/playlist?list=PLLt4b1sGHpn1fvcNnc2DjWPKG8pAgu2SY

Click on any video labeled "Rick is Programming: Wordle in Swift (CLI)"

## External Dependency

This program uses rderik/SwiftCursesTerm:

https://github.com/rderik/SwiftCursesTerm
