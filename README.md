UppitDL
=======

This short snippet essentially finds the direct download link on a regular Uppit download page and (optionally) downloads that specified file. In short, it basically allows an individual to find the direct URL so he or she can download that file without having to access a browser and then waiting five or so seconds before downloading it. Due to the fact that it is very easy for the Uppit administrators to eradicate this program's Regex parsing, it is not recommended to rely on this program at all.

Note: The generated link for the direct download is probably not permanent (Uppit probably changes this on a routine basis); however, I am not completely sure that my hypothesis is correct.


Usage
-----

This program currently works on Linux and Mac OS X.

To use:

    ruby uppitdl.rb URL_PATH

Use the argument -n (at the end) to not download the file (and only return the URL).


TODO
----

 - Improve program functionality.
 - Make this cross-platform.
 - Improve Regex to ensure better future usage (if the site output is changed, for example).
 - Don't use Regex.

Disclaimer
----------

You should use this software for either convenience purposes or educational purposes only. Help Uppit by visiting its actual site!