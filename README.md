# nvidia-l4t-base-plex
Running Plex Media Server on Nvidia L4T (Linux for Tegra)  docker container.


# Setup

After running the create-container.sh file successfully, follow the below steps.

Run the plex-entrypoint.sh file located at "/" inside the docker container.

To begin configuring the Plex Media Server, browse to http://localhost:32400/web/.

To configure Plex Media Server remotely, you can first create an SSH tunnel (setup can only be done from localhost)

$ ssh ip.address.of.server -L 8888:localhost:32400
and then browse to http://localhost:8888/web/.

# Note

In order for plex to play nicely with symbolic links to media files make sure that plex running from the docker container has at least read access to the source media files, and make sure that you create relative symbolic links to the source media files instead of using absolute paths. Both the source media files and the relative symbolic links need to be accessible from within the docker container.

Use the below guide in order to setup media folder structure as per plex's requirement.

https://support.plex.tv/articles/naming-and-organizing-your-tv-show-files/

Naming and Organizing Your TV Show Files
The scanners and metadata agents used by Plex will work best when your major types of content are separated from each other. We strongly recommend separating movie and television content into separate main directories. For instance, you might use something like this:

/Media
   /Movies
      movie content
   /Music
      music content
   /TV Shows
      television content
Warning!: Plex will do its best to appropriately find and match the content. However, a failure to separate content such as movies and TV shows may result in unexpected or incorrect behavior.

In the above example, it is the main folder of each type of content (e.g. /Movies, /Music, /TV Shows) that you would typically specify as the content location for that library type.

Tip!: More specifically, the folder you want to specify as the content location for the library is the folder that contains each of the individual show folders. So, if you chose to categorize your children’s content separate from more “adult” content (e.g. /TV Shows/Kids/ShowName vs /TV Shows/Regular/ShowName), then you would specify /TV Shows/Kids as the source location for a “kids” TV library.

TV shows can be season-based, date-based, a miniseries, or more. Both the folder structure and each episode filename must be correct for the best matching experience. If you’re not sure whether a show is season- or date-based, check The Movie Database (TMDB) or The TVDB and name it as it appears there.

By default, the Plex TV Series agent uses the episode ordering based on TMDB. However, if you know that your files are named according TVDB, you can change the Episode Ordering preference (under Advanced) when creating or editing your TV library. Examples of the file naming/organization mentioned can be found at the end of the article.

Some important notes:

For the “Plex TV Series” agent, it is recommended to always include the year alongside the series title in folder and file names, e.g. /Band of Brothers (2001)/Season 01/Band of Brothers (2001) - s01e01 - Currahee.mkv
Be sure to use the English word “Season” when creating season directories, even if your content is in another language.
Many of our naming instructions mention having Optional_Info at the end of the file name. As the label suggests, it’s optional, but many people like to use it for things such as an episode title. Such optional info is ignored by Plex when matching content with legacy agents, but it is used in the Plex TV Series agent to give a hint for matching. If you want info to be ignored put the optional info in brackets. e.g. /Band of Brothers (2001) - s01e01 - Currahee [1080p Bluray].mkv
We use .ext as a generic file extension in the naming/organizing instructions. You should use the appropriate file extension for your files, of course. (Some operating systems such as Windows may hide your file extensions by default.)
If you are using the “Plex TV Series” agent, you can optionally include the TMDB or TVDB show ID in the folder name to improve matching. If you choose to do that, it must be inside curly braces: ShowName (2020) {tvdb-123456} or ShowName (2020) {tmdb-123456} where 123456 is the show ID. An example can be found at the end of the article.
Standard, Season-Based Shows
Most television shows have episodes organized into seasons. To name season-based shows create files with the season and episode notation sXXeXX:

/TV Shows/ShowName/Season 02/ShowName – s02e17 – Optional_Info.ext
This is only an example. The most important bit in the file name is the appropriate season and episode number notation s02e17 which in this example means Season 2 Episode 17 It does not matter if you use dashes, dots or just spaces.

Date-Based Television Shows
TV Shows that are date-based should be named as follows:

/TV Shows/ShowName/Season 02/ShowName – 2011-11-15 – Optional_Info.ext
/TV Shows/ShowName/Season 02/ShowName – 15-11-2011 – Optional_Info.ext
Where you specify the appropriate date. The date can use either the YYYY-MM-DD or DD-MM-YYYY formats and can use different separators:

Dashes (2011-11-15)
Periods (2011.11.15)
Spaces (2011 11 15)
Miniseries
A miniseries is really handled just like a season-based show, you simply always use “Season 01” as the season.

Television Specials
Shows sometimes air “specials” or other content that isn’t part of the standard season. “Specials” episodes are always part of season zero (i.e. season number “00”)  and should be placed inside a folder named either Season 00 or Specials.

/TV Shows/ShowName/Specials/ShowName – s00e13 – Optional_Info.ext
Where you specify the correct episode numbers. If you’re unsure whether a particular episode is a Special or not, check the episode on TheTVDB and name it as you see it there.

If an “episode” you have doesn’t appear in TheTVDB (e.g. DVD Specials or goof reel), place this content in the Season 00 or Specials folder named using s00eYY using a false “YY” number (e.g.: Heroes s00e99). The show will be available to play in a Plex App but won’t have any special metadata gathered, such as a summary.

Multiple Episodes in a Single File
If a single file covers more than one episode, name it as follows:

/TV Shows/ShowName/Season 02/ShowName – s02e17-e18 – Optional_Info.ext
Where you specify the appropriate season, episode numbers (the first and last episode covered in the file), and file extension.

Note: Multi-episode files will show up individually in Plex apps when viewing your library, but playing any of the represented episodes will play the full file. If you want episodes to behave truly independently, you’re best off using a tool to split the file into individual episodes.

To get a better overall experience, you may wish to use a tool to split the video so that each episode has its own individual file. There are multiple ways you can do this and a quick search in your favorite search engine should give you some options on how to “split” a file. An unofficial guide with one free tool has even been posted in our forums.

Related Page: Forums: Splitting multi-episode files with MKVtoolnix GUI

Episodes Split Across Multiple Files
Episodes that are split into several files (e.g. pt1, pt2), can be played back as a single file if named correctly. Name the files as follows:

/TV Shows/ShowName/Season 02/ShowName – s02e17 – Split_Name.ext
Where Split_Name is one of the following:

cdX
discX
diskX
dvdX
partX
ptX
…and you replace X with the appropriate number (cd1, cd2, etc.).

Notes:

Not all Plex apps support playback of stacked media
All parts must be of the same file format (e.g. all MP4 or all MKV)
All parts should have identical audio and subtitle streams in the same order
Only stacks up to 8 parts are supported
To get a better overall experience, you may wish to use a tool to join/merge the individual files into a single video. There are multiple ways you can do this and a quick search in your favorite search engine should give you some options on how to “join” files. An unofficial guide with one free tool has even been posted in our forums.

Related Page: Forums: Joining multi-part movie files with MKVtoolnix GUI

Examples
Note: This example illustrates many of the types of content outlined previously. When creating the TV library, it is the /TV Shows directory that would be specified as the content location for the library.

/TV Shows
   /Doctor Who (1963) {tvdb-76107}
      /Season 01
         S01e01 - An Unearthly Child (1).mp4
         S01e02 - The Cave of Skulls (2).mp4
   /From the Earth to the Moon (1998)
      /Season 01
         From the Earth to the Moon (1998) - s01e01.mp4
         From the Earth to the Moon (1998) - s01e02.mp4
   /Grey's Anatomy (2005)
      /Season 00
         Grey's Anatomy (2005) - s00e01 - Straight to the Heart.mkv
      /Season 01
         Grey's Anatomy (2005) - s01e01 - pt1.avi
         Grey's Anatomy (2005) - s01e01 - pt2.avi
         Grey's Anatomy (2005) - s01e02 - The First Cut is the Deepest.avi
         Grey's Anatomy (2005) - s01e03.mp4
      /Season 02
         Grey's Anatomy (2005) - s02e01-e03.avi
         Grey's Anatomy (2005) - s02e04.m4v
   /The Colbert Report (2005)
      /Season 08
         The Colbert Report (2005) - 2011-11-15 - Elijah Wood.avi

# References

https://github.com/NVIDIA/nvidia-docker/wiki/NVIDIA-Container-Runtime-on-Jetson

https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/user-guide.html

https://catalog.ngc.nvidia.com/orgs/nvidia/containers/l4t-base

https://gitlab.com/nvidia/container-images/l4t-base/-/tree/master/

https://repo.download.nvidia.com/jetson/

https://wiki.archlinux.org/title/Plex

https://github.com/plexinc/pms-docker/blob/master/Dockerfile.arm64

https://github.com/plexinc/pms-docker/blob/master/docker-compose-host.yml.template

https://stackoverflow.com/questions/60485743/how-to-use-docker-entrypoint-with-shell-script-file-combine-parameter

https://stackoverflow.com/questions/71878197/what-are-arg-and-label-in-a-dockerfile

https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3261/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/multimedia.html#wwpID0E0GC0HA

https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3261/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/multimedia.html#wwpID0EQHA

https://docs.nvidia.com/jetson/archives/l4t-archived/l4t-3261/index.html#page/Tegra%20Linux%20Driver%20Package%20Development%20Guide/accelerated_gstreamer.html#wwpID0E0R40HA

https://repo.download.nvidia.com/jetson/

https://gitlab.com/nvidia/container-images/l4t-base

https://www.reddit.com/r/PleX/comments/bbgpzg/symbolic_links_not_working_with_plex/
