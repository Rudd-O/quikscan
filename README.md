# QuikScan: a simple GUI for hp-scan

This utility will use `hp-scan` (from the `hplip` HP utilities package)
to scan (multipage, and double-sided) PDF documents while you observe.

It requires `hplip` on your system installed.

# Installation

Create a package using RPM on this directory:

```bash
make rpm
```

Or install directly to your system

```bash
sudo make install
```

# Usage

Check your desktop's menu for the QuikScan application, and launch it.

You can select what type of scan you want (double-sided or single-sided)
and what size document you will be scanning (A4 or letter).  At this
point it is not possible to use flatbed scanning because the program
does not yet implement the ability to stop between pages.  That will
come in a future version.

Type a file name or select one.  Hit *Save*.

That's it.
