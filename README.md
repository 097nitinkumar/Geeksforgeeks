# Website Extractor
Contains commands to download website for offline viewing


Source:
https://www.reddit.com/r/india/comments/63165r/how_do_i_download_an_offline_version_of_the/
Solution:
wget --mirror --convert-links --adjust-extension --page-requisites --no-parent http://www.geeksforgeeks.org/

Explanation of the various flags:

--mirror – Makes (among other things) the download recursive.
--convert-links – convert all the links (also to stuff like CSS stylesheets) to relative, so it will be suitable for offline viewing.
--adjust-extension – Adds suitable extensions to filenames (html or css) depending on their content-type.
--page-requisites – Download things like CSS style-sheets and images required to properly display the page offline.
--no-parent – When recursing do not ascend to the parent directory. It useful for restricting the download to only a portion of the site.
NOTE:despite being an awesome approach,there are some bugs,
few of the web pages are NOT dowloaded,images are still refered
to the webpage,images added to webpages through css file are will be accessible or not,not clear.


Alternatively, the command above may be shortened:

wget -mkEpnp http://example.org
Note: that the last p is part of np (--no-parent) and hence you see p twice in the flags.


Hence writting my own script on linux shell using curl tools
