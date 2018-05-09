# Geeksforgeeks
Contains commands to download website for offline viewing



https://www.reddit.com/r/india/comments/63165r/how_do_i_download_an_offline_version_of_the/
gave this approach
wget --mirror --convert-links --adjust-extension --page-requisites --no-parent http://www.geeksforgeeks.org/
//works like charm 
wget -nd -r -P /save/location -A jpeg,jpg,bmp,gif,png http://www.somedomain.com
Here is some more information:

-nd prevents the creation of a directory hierarchy (i.e. no directories).

-r enables recursive retrieval. See Recursive Download for more information.

-P sets the directory prefix where all files and directories are saved to.

-A sets a whitelist for retrieving only certain file types. Strings and patterns are accepted, and both can be used in a comma separated list (as seen above). See Types of Files for more information.

but images not downloaded


-nc
       --no-clobber
           If a file is downloaded more than once in the same directory,
           Wget's behavior depends on a few options, including -nc.  In
           certain cases, the local file will be clobbered, or overwritten,
           upon repeated download.  In other cases it will be preserved.

           When running Wget without -N, -nc, -r, or -p, downloading the same
           file in the same directory will result in the original copy of file
           being preserved and the second copy being named file.1.  If that
           file is downloaded yet again, the third copy will be named file.2,
           and so on.  (This is also the behavior with -nd, even if -r or -p
           are in effect.)  When -nc is specified, this behavior is
           suppressed, and Wget will refuse to download newer copies of file.
           Therefore, ""no-clobber"" is actually a misnomer in this
           mode---it's not clobbering that's prevented (as the numeric
           suffixes were already preventing clobbering), but rather the
           multiple version saving that's prevented.

 -x
       --force-directories
           The opposite of -nd---create a hierarchy of directories, even if
           one would not have been created otherwise.  E.g. wget -x
           http://fly.srk.fer.hr/robots.txt will save the downloaded file to
           fly.srk.fer.hr/robots.txt.

 --default-page=name
           Use name as the default file name when it isn't known (i.e., for
           URLs that end in a slash), instead of index.html.


       --referer=url
           Include `Referer: url' header in HTTP request.  Useful for
           retrieving documents with server-side processing that assume they
           are always being retrieved by interactive web browsers and only
           come out properly when Referer is set to one of the pages that
           point to them.
