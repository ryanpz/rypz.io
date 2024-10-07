+++
title = "Silencing All Output of a Command in POSIX shell"
date = 2024-03-06
+++

It's often useful to test the exit codes of commands to make decisions. For example,

```sh
if which vi; then
  printf 'vi is installed\n'
fi
```

A problem here is that the command, like in this example, may output lines to `STDOUT` and `STDERR`,
which is usually not what we want.

To silence `STDOUT`, we can redirect it to `/dev/null`, the null device.

```sh
which vi >/dev/null
```

We _could_ do the same for `STDERR`, but it's idiomatic to redirect `STDERR` to `STDOUT` instead, thereby
redirecting both outputs to `/dev/null`. This is done using the `>&` redirection operator.

```txt
[n]>&[m]
```

This works by making file descriptor `n` a copy of file descriptor `m`. In other words, all output sent to `n` is
redirected to `m`.

The example then becomes

```sh
if which vi >/dev/null 2>&1; then
  printf 'vi is installed\n'
fi
```

---
[The Open Group Base Specifications Issue 8 (2.7.6 Duplicating an Output File Descriptor)](https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_07_06)
