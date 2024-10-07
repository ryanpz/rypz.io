+++
title = "Using Parameter Expansion in POSIX Shell"
date = 2022-08-21
+++

In POSIX shell scripting, we can use parameter expansion to reference a variable

```sh
message="hello"
echo ${message}
```

The usefulness of this syntax is in its variations that handle variables when null/not null:

| Form         | Meaning                                                |
|--------------|--------------------------------------------------------|
| ${var:-word} | use _word_ if _var_ unset/null                         |
| ${var:=word} | use _word_ and set _var_ to _word_ if _var_ unset/null |
| ${var:+word} | use _word_ if _var_ set and not null                   |
| ${var:?word} | exit with error and print _word_ if _var_ unset/null   |

---
[The Open Group Base Specifications Issue 7 (2.6.2 Parameter Expansion)](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02)
