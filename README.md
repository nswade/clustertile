# clustertile

This is a unix-type bash script for converting HD and UHD video content into OSG tile
clusters for playback in MediaCommons software on CGLX video walls. 

CGLX: a flexible, transparent, and extensible system and framework for scalable, distributed, high-performance visualization environments. 
http://vis.ucsd.edu/~cglx/

MediaCommons: a scalable abstraction for tiled display environments
http://sc13.supercomputing.org/sites/default/files/WorkshopsArchive/pdfs/wp154s1.pdf

The script requires FFMPEG and Python 2.7

Usage: sh clustertile.sh [INPUT_DIR_FILE] [OUTPUT_DIR] [OUTPUT_PREFIX]
[WIDTH] [HEIGHT] [COL] [ROW]

Example:
user$> sh clustertile.sh /foo/foo.mp4 /bar test 3840 2160 8 8

Tested working at 16, 32, 64 tiles on UHD, 4K and irregular source sizes. Depending on the source resolution and level of subdivision FFMPEG crop streaming can be fast or take some time. Transcoding your source content to H264 before running the
clustertile script can speed things up significantly.

