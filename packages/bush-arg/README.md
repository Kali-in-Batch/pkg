# bush

[![Build Status](https://travis-ci.org/dylanaraps/bush.svg?branch=master)](https://travis-ci.org/dylanaraps/bush)

This is an experiment to see how many standard tools and functions we can re-implement in pure bash. No external processes are used, only shell builtins. Bush is not meant to be used for anything serious and there's probably edge cases and bugs throughout.

Feel free to hack around with this, that's the entire point anyway. ¯\\\_(ツ)\_/¯


## How to use this?

Source the file and provide the command as an argument.

```sh
/path/to/bush/bush-arg command
```

Make sure it's executable.

```sh
chmod +x /path/to/bush/bush-arg
```