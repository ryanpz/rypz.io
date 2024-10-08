+++
title = "Defining Options and Option Arguments in POSIX Shell"
date = 2022-06-10
+++

In a Unix environment, it's very common for a command-line utility to accept options using the following syntax:

```sh
utility_name [-a] [-b] [-c option_argument]
    [-e] [-f[option_argument]] [operand...]
```
> *Utility Argument Syntax*: An option is identified by a minus [-] sign followed by a single letter, along with an argument if the option requires one.

In POSIX shell scripts, these options can be parsed using the builtin `getopts` command.

## Syntax
```sh
getopts OptionString NAME [ARGS...]
```

## Parameters
* **OptionString**: a series of letters defining valid options.
    * To define an option as one that **requires an argument**, add a colon `[:]` directly after the option character
* **NAME**: `getopts` sets this variable to the option character that was found
* **ARGS**: tell `getopts` to parse **ARGS** for options instead of the arguments passed to the script *(mostly used for debugging)*

## Typical Usage
```sh
while getopts s:rg: o; do
  case "$o" in
    s) printf "option s set with arg %s\n" "$OPTARG";;
    r) printf "option r has been set\n";;
    g) printf "option g set with arg %s\n" "$OPTARG";;
    *) printf "usage: %s [-s s_arg] [-r] [-g g_arg]\n" "$0";;
  esac
done
shift $((OPTIND-1))
```

Each time `getopts` is invoked, it sets:

- **NAME** to the option character it found
- **OPTARG** to the option's argument, if the option requires one
- **OPTIND** to the index of the next argument to be processed

When there are no more options to process, `getopts` exits with a nonzero value, and **OPTIND** is set to the index of the first non-option argument.

If the program also accepts non-option arguments, it's idiomatic to add the following after parsing options:
```sh
shift $((OPTIND-1))
```
This line effectively **removes all the parameters parsed by getopts from the parameter list**. After this line, `$1` will be the first non-option argument, and `$#` will be the number of non-option arguments.

---
[The Open Group Base Specifications Issue 7 (getopts)](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/getopts.html), [The Open Group Base Specifications Issue 7 (12.1 Utility Argument Syntax)](https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html)
