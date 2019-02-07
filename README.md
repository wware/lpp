# Literate programming preprocessor

Knuth's original vision for literate programming involved a single source file that
could be processed in two different ways to produce compilable code on one pathway
and a TeX/LaTeX source doc on the other. This approach diverges from that, using two
sources, one of them an unmodified source code file.

There are a few reasons for this divergence. First, the large volume of legacy code
that hadn't yet been written in Knuth's day. Second, the large number of very useful
tools that now exist and that assume their input is a normal source code file, not
some strange predecessor to a source code file. Third, modern engineers don't want
to learn some new scheme of deriving their source code from some other document
format.

The preprocessor should be as agnostic as possible about how documents are processed.
LaTeX, Markdown, HTML, and any other format should work. Currently there are examples
for LaTeX and Markdown.

## The first of two modes of operation

Both modes are ways to import chunks of code into a document. A chunk of code is
a group of contiguous lines.

The first mode is for source code that has no form of tags or markup or special comments.
This is appropriate with legacy code, or where the code itself cannot be practically
modified (for instance, documenting code to which you don't have commit privileges,
such as the Linux kernel).

The chunk of code in a document is specified by a sequence of regular expressions.
The last two in the sequence specify the starting and ending line of the snippet
and the earlier regexes are steps to get you to the staring line. For instance you
get to a particular method in a particular class in a particular file with something
like this, where the "@" sign is the left-most character in the line, signaling the
preprocessor that this line is to be preprocessed.

```
    @foobar.py:class Foobar/def foo\(self\)/x = 3/print x
```

produces

```
@foobar.py:class Foobar/def foo\(self\)/x = 3/print x
```


So the first source for this scheme is a normal source code file, with no modifications
whatsoever on behalf of this approach. There are no extra comments or tags or markup
of any sort. Zero impact on source code is a hard requirement of this approach.


To include a code snippet into a document, you use a sequence of regular expresssions.
The last two in the sequence specify the starting and ending line of the snippet
and the earlier regexes are steps to get you to the staring line. For instance you
get to a particular method in a particular class in a particular file with something
like this.

## The second mode

In this case we use special markup to specify the first and last lines of a named chunk.
By default the markup uses hashtag-style comments, like this.

    before before before
    code code code code     #+chunkname
    code code code code
    code code code code     #-chunkname
    after after after

With the prefix and suffix command line options, the "#" can be replaced with other
character sequences. For instance with `--prefix '/**' --suffix '*/'` you could use
code with markup like this.

    before before before
    code code code code     /**+chunkname*/
    code code code code
    code code code code     /**-chunkname*/
    after after after

An example from the `foobar.py` file looks like this.

```
@foobar.py:otherstuff
```

The reason for including this second mode is because if the regular expressions in the
first mode aren't kept maintained as the code evolves, references can quickly start to
fail, whereas markup placed in the source code itself will more easily and more likely
be maintained across significant refactorings.

# Use grip to see it working

To see this in action, install `grip` (a command line markdown renderer) and then type

```
./lpp < README.md | grip -
```

then go to http://localhost:6419 in a browser.

# Is there anything else I would want?

I've got the two modes of including code, that's good.

What else would be good? One thing would be a server that automatically does the weave
when you request a markdown page. It would need to get a directory as an argument to the GET
and the server would require access to that directory, so it would be smart to run the
server in the repository where you're working. Maybe there is a dot-rc file in the directory,
or if a dot-rc file is not found we just use the current directory.

This server could really just be a script, something like this, with a little bit more
complexity for the dot-rc file.

```
@serve.sh
```
