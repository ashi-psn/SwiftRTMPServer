#!/bin/sh
ffmpeg -re -stream_loop -1 -i video.mp4 -vcodec libx264 -vprofile baseline -g 30 -acodec aac -strict -2 -f flv rtmp://localhost/live