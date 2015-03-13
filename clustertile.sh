#!/bin/bash
# Rev021115
# Nathan Wade
#
# This script creates cluster optimized OpenSceneGraph quad tiles with metadata 
# from a single HD video source for synchronous playback on MediaCommons CGLX video walls.  
#
# http://sc13.supercomputing.org/sites/default/files/WorkshopsArchive/pdfs/wp154s1.pdf
# http://vis.ucsd.edu/~cglx/
#
# required: FFMPEG, Python 2.7
# usage: sh scriptname INPUT_DIR_FILE OUTPUT_DIR OUTPUT_PREFIX WIDTH HEIGHT COL ROW

echo "INPUT_DIR_FILE: $1"
#ffmpeg -i $1
echo "OUTPUT_DIR: $2"
echo "OUTPUT_PREFIX: $3"
echo "WIDTH: $4"
echo "HEIGHT: $5"
echo "COL: $6"
echo "ROW: $7"

mkdir $2/$3/
touch $2/$3.xml


PYTHON_ARG="$1 $2 $3 $4 $5 $6 $7" python - <<END

import os
import subprocess as sp

FMPEG_BIN = "ffmpeg" # unix, os x
FFMPEG_BIN = "ffmpeg.exe" # ms windows

XML = open('$2/$3.xml','w')
XML.write("<?xml version=\"1.0\"?>\n<RenderableDataObject type=\"tiled_video\">\n")

cW = $4/$6
cH = $5/$7
cRow = 0
cCol = 0

for col in range(0,$6):
	for row in range(0,$7):
		XML.write('    <tile path=\"$2/$3/%i-%i.mp4\" column=\"%i\" row=\"%i\" />\n'%(cCol, cRow, cCol, $7-cRow-1))
        
        #ffmpeg -i in.mp4 -filter:v "crop=out_w:out_h:x:y" [-an | -c:a copy] out.mp4 -y
		command = [ FMPEG_BIN,
            '-i', '$1',
            '-filter:v', 'crop=%i:%i:%i:%i'%(cW,cH, cW*cCol, cH*cRow),
            '-an','$2/$3/%i-%i.mp4'%(cCol, cRow),
            '-y']
		pipe = sp.Popen(command, stdout = sp.PIPE, bufsize=10**8)

		cRow+=1
		
	cRow = 0
	cCol+=1

XML.write("</RenderableDataObject>\n")
XML.close
END

exit





