+++
title = "Getting All Positional Parameters in POSIX Shell"
date = 2022-08-21
+++

In POSIX shell scripts, we have two options to reference _all_ positional parameters that the script was invoked with:

1. `$@`
2. `$*`

The difference between the two is:

- `$@` retains the spaces of a parameter if the parameter's value is double-quoted.
- `$*` treats spaces _within_ parameters, and spaces _between_ parameters **the same**.

It is usually a better idea to stick to **using** `$@` for more predictable and reliable parameter parsing.

---
[The Open Group Base Specifications Issue 7 (2.5.2 Special Parameters)](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_05_02)
