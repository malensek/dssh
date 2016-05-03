1.1
---
* Add option to re-enable disabled hosts (prefixed with #)

1.0
---
* PTYs can now be allocated (-y). This enables screen-based tasks like top(1) to run and also allows job control. For instance, ^C will terminate remote jobs.
* Alias for 'job execution mode' (-j), which is short for -Apy. Executes long-running tasks on multiple machines, actively prints their output to the controlling terminal, and supports job control.
* A configurable delay can be added after each command executes
* Smart color support; color will be disabled if piping to a file or another program

0.9
---
* Allows 'commenting out' host names with the # character to skip particular hosts

0.8
---
* Active printing of ssh commands (unlike -p, this interleaves the output of several tasks, with a 'host name | ' prefix)

0.7
---
* Added a timeout flag for hosts that are slow to respond

0.6
---
* Option to authenticate with an identify file (helpful for AWS etc)
* Fixed a trap recursion bug in newer versions of bash
