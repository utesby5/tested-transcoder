# tested-transcoder (Dockerized)
## --- THIS IS A BETA RELEASE --

This is a fork from the tested-transcoder (https://github.com/andymccurdy/tested-transcoder) ported to Docker (instead of vagrant). It also uses the new video_transcoding gem instead of the old bash scripts (https://github.com/donmelton/video_transcoding)

To rip discs, first use MakeMKV to rip only the movie, audio tracks, and subtitles you want. The title with the most chapters, and largest size is typically the one you want. I typically tell MakeMKV to grab all the English language subtitles and audio tracks, which is a generally a good strategy. You can set this as the default in View > Preferences > Language > Preferred Language. The process may take a long time, depending on your computer and the resources you give the black box.

## Prerequisites

* Docker Engine - https://docs.docker.com/engine
* Git - http://git-scm.com/downloads
* MakeMKV - http://www.makemkv.com/download/

## Installation
1. Install the prerequisites.
2. Create a folder where you will copy source videos to and collect transcoded videos from. (We use `/custom/folder` in this example)

## Usage
1. Use MakeMKV to rip the Bluray / DVD
2. Start a Docker container:
    ```
        docker run -d --name tested-transcoder -v /custom/folder:/media/transcoder excape/tested-transcoder --preset medium
    ```
    Replace `/custom/folder` with the new folder. `/media/transcoder` must not be changed.

    If this doesn't work, try building the image manually (see below).
    
    `--preset` is optional and determines the quality of the resulting video. Faster means faster transcoding, but lower quality, and slower means greater quality, but slower transcoding. See the [video_transcoding README](https://github.com/donmelton/video_transcoding#understanding-the-x264-preset-system) for more info. (default: `medium`)

    Replace `--preset medium` with `--quick` to use a performance optimized preset.
3. When the container startet correctly, the folders `input`, `output`, `work` and `completed-originals` should appear in the target directory (your folder created before)
4. Starting your encodes is as easy as dragging a video from MakeMKV into the 'input' folder.
5. When the encode is in progress, you can check in on its progress by looking at the end of the log in the 'work' folder.
6. When the encodes are complete, the new, better compressed video will be in the 'output' folder and the original source MKV will be in the 'completed-originals' folder. After you've confirmed subtitles and audio tracks are correct, you can safely delete the large original file.
7. Enjoy your new, much smaller MKV in your favorite media player.

## Build manually
    git clone https://github.com/Excape/tested-transcoder.git
    cd tested-transcoder
    docker build -t excape/tested-transcoder .
