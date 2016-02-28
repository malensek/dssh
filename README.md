dssh
====

dssh is a simple tool for distributing ssh commands across a cluster of machines. See usage details below or checkout the [examples](examples.md).

Dependencies
------------
* Bash 
* Perl (on non-Linux systems)


* * *


NAME
====

**dssh** - ssh for clusters

SYNOPSIS
========

**dssh** \[-aAcjpqy\] \[-f host\_file...\] \[-i id\_file\] \[-l host-list...\] \[-o ssh\_opts\] \[-u username\] \[-s timeout\] \[-t max\_threads\] *command*

DESCRIPTION
===========

**dssh** is a simple utility designed for executing commands across several hosts via ssh. Commands may be executed in parallel or sequentially, and a variety of formatting and output options are supported.

Remote hosts for command execution are specified by file(s), lists on the command line, or hostnames piped from standard input. Whitespace is used to distinguish between hosts. A connection is made to each host via ssh and the user-defined *command* is executed.

While the basic functionality provided by **dssh** can be mimicked with a few lines of shell script, additional features such as limiting the number of active threads, output collection/formatting, and colorization are supported.

OPTIONS
=======

-a  
Enable 'active' printing of ssh output instead of buffering it until the command completes. Since this may result in interleaved outputs from multiple hosts, the remote hostname is prepended to each output line.

-A  
Enable active printing with abbreviated hostnames, where only the first part of the name is shown (up to the first '.' character). Useful for long hostnames.

-c  
Enable colorized output. Automatically disabled if stdout is not a terminal.

-i *id\_file*  
Selects an identity file containing a private key to use for authentication.

-j  
x

-o *ssh\_opts*  
Adds options to be passed through to the ssh command line. Options should be quoted to avoid confusing the dssh option parser.

-p  
Executes remote commands in parallel, with each remote connection launched on a separate thread (no thread limit). By default, output is buffered and printed after the command completes unless active printing (**-a**) is used.

-q  
Quiet output mode; silences extra output, such as hostnames and extra newlines. Error messages will still be displayed.

-u *username*  
Authenticate using a different name than the current user.

-s *timeout*  
Configures how long to wait (in seconds) before timing out remote connections.

-t *num\_threads*  
Limits the number of threads used during parallel execution (implies **-p**).

-y  
x

EXIT STATUS
===========

Nonzero if errors occurred.

ENVIRONMENT
===========

The *DSSH\_HOSTS* environment variable affects the starting host list. Additional hosts may be added using the usual flags.

AUTHOR
======

Matthew Malensek <matt@malensek.net>
http://sigpipe.io/dssh
