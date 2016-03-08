dssh
====

dssh is a simple tool for distributing ssh commands across a cluster of machines. See the usage details below or check out the [examples](#usage-examples).

Dependencies
------------
* Bash 
* Perl (on non-Linux systems)

Installation
------------
Since dssh is just a Bash script, you don't need to compile it. A Makefile is provided to conveniently install dssh and its man page based on your PREFIX environment variable.

You can also install via [Homebrew](http://brew.sh):

    brew tap malensek/dssh
    brew install dssh

<br>
<br>

* * *


NAME
====

**dssh** - ssh for clusters

SYNOPSIS
========

**dssh** \[-aAcjpqy\] \[-f host\_file...\] \[-i id\_file\] \[-l host\_list...\] \[-o ssh\_opts\] \[-u username\] \[-s timeout\] \[-t max\_threads\] *command*

DESCRIPTION
===========

**dssh** is a simple utility designed for executing commands across several hosts via ssh. Commands may be executed in parallel or sequentially, with a variety of formatting and output options.

Remote hosts for command execution are specified by file(s), lists on the command line, the DSSH\_HOSTS environment variable, or hostnames piped from standard input. Whitespace is used to distinguish between hosts. A connection is made to each host via ssh and the user-defined *command* is executed.

While the basic functionality provided by **dssh** can be mimicked with a few lines of shell script, additional features such as limiting the number of active threads, output collection/formatting, and colorization simplify the advanced cases.

OPTIONS
=======

-a  
Enable 'active' printing of ssh output instead of buffering it until the command completes. Since this may result in interleaved outputs from multiple hosts, the remote hostname is prepended to each output line.

-A  
Enable active printing with abbreviated hostnames, where only the first part of the name is shown (up to the first '.' character). Useful for long hostnames.

-c  
Enable colorized output. Automatically disabled if stdout is not a terminal.

-f *host\_file*  
Adds plain-text file(s) of machine hostnames to the master host list. Hostnames must be separated by whitespace.

-i *id\_file*  
Selects an identity file containing a private key to use for authentication.

-j  
Enables *job mode* (alias for -Apy). This mode is useful for executing long-running processes on a collection of remote machines, as any output from the processes will be printed immediately and job control will be enabled (i.e., pressing ^C will terminate remote jobs, if supported).

-l *host\_list*  
Adds a list of hostnames specified as a string to the master host list. Hostnames must be separated by whitespace.

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
Allocates a pseudoterminal (PTY). This allows remote screen-based applications to run (such as top(1)), and also enables job control. Care should be taken when redirecting output to files, and the **-q** (quiet) option may be useful if output becomes garbled.

EXIT STATUS
===========

Nonzero if errors occurred.

ENVIRONMENT
===========

The *DSSH\_HOSTS* environment variable affects the starting host list. Additional hosts may be added using the usual flags listed above.

USAGE EXAMPLES
==============

Retrieve uptime information for several hosts in *hosts.txt*:

    dssh -f hosts.txt 'uptime'

Retrieve uptime information as above, but in parallel. To make errors more visible, we enable colorization:

    dssh -p -c -f hosts.txt 'uptime'

Sort our list of hostnames, and then determine who is logged in to each machine. To avoid opening too many connections at once, limit the number of active threads to two:

    sort hosts.txt | dssh -t 2 'who'

Check the contents of /tmp on our cluster of cloud instances using different credentials, and time out connections after 1 second if the remote host doesn't respond:

    dssh -u ec2-user -i credentials.pem.txt -s 1 'ls /tmp'

Run a distributed application on a list of hosts and print output to the local terminal. Also enable job control so when we terminate dssh with ^C all the remote processes are terminated as well:

    dssh -A -p -y -l "host1 host2 host3" 'java -jar ./myapp.jar'

Perform the same operation as above, but use the **-j** alias for -Apy:

    dssh -j -l "host1 host2 host3" 'java -jar ./myapp.jar'

Determine whether Jane is logged in on a set of hosts that run SSH on a non-standard port, using IPv6:

    dssh -pf hosts5000v6.txt -o'-6 -oPort=5000' 'w' | grep -i jane

Print out hosts that do not have a particular directory in their file system (note we suppress extra output with **-q**):

    dssh -q -pf hosts.txt 'ls -d /data/mydir &> /dev/null || hostname'

WEBSITE
=======

http://sigpipe.io/dssh
