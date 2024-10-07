+++
title = "Getting All Positional Parameters in POSIX Shell"
date = 2022-08-21
+++

The POSIX shell language provides two _special parameters_ to get all positional parameters that the script was invoked with:

1. `$@`
2. `$*`

Both behave similarly when not double-quoted: field splitting is performed on the each parameter. This means that even if a positional argument is quoted, it'll still be split up by IFS—which is whitespace by default—into separate fields. For example,

```sh
#!/bin/sh
#
# foo.sh

printf 'printing out all params using $*:\n'
for i in $*; do
  printf '%s\n' "$i"
done

printf '\nprinting out all params using $@:\n'
for i in $@; do
  printf '%s\n' "$i"
done
```

Executing it will output:

```
$ ./foo.sh a "b c d" e
printing out all params using $*:
a
b
c
d
e

printing out all params using $@:
a
b
c
d
e
$
```

These special parameters behave differently when between double quotes:

- `"$@"` does not perform word splitting on the positional parameters.
- `"$*"` joins all positional parameters into a single field, separated by the first character of IFS.

To better illustrate this important difference:

```sh
#!/bin/sh
#
# bar.sh

printf 'printing out all params using "$*":\n'
for i in "$*"; do
  printf '%s\n' "$i"
done

printf '\nprinting out all params using "$@":\n'
for i in "$@"; do
  printf '%s\n' "$i"
done
```

Output:

```
$ ./bar.sh a "b c d" e
printing out all params using "$*":
a b c d e

printing out all params using "$@":
a
b c d
e
$
```

## Takeaways

**Always Use `"$@"`**

- Due to word splitting, using either special parameter outside of double quotes can be unpredictable; the resulting number of arguments, along with their values and positions, could all differ from what they originally were depending on the values provided.
- `"$*"` is far less useful. Needing to combine all positional parameters into a single argument is a rare situation.

---
[The Open Group Base Specifications Issue 7 (2.5.2 Special Parameters)](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_05_02)
