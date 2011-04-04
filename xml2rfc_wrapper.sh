#!/bin/sh

# The point of this rigamorole is that not all tclsh
# versions are equal. If your IT department has the wrong
# tclsh for xml2rfc, use the XML2RFCPATH environment variable
# to give to a better one. E.g., one of the editors
# has /u/mre/bin/rfc at the start of his XML2RFCPATH
# variables.

if [ "$XML2RFCPATH" != "" ]
then
	PATH=$XML2RFCPATH
	export PATH
fi

exec ${XML2RFCDOT}./xml2rfc-1.36/xml2rfc.tcl $*
