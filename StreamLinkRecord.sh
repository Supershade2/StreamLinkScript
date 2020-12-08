#!/bin/bash
username=$(whoami);
current_date_time=`date "+%Y%m%d%H%M%S"`;
echo $current_date_time
echo Use a previously entered name?
read answer
if [ "$answer" != "yes" ]; then
echo What is the channel name of the twitch streamer?
read name
streamlink --player-http twitch.tv/$name
echo "What quality do you want?"
read quality
echo $name >> /home/$username/Documents/channellist.txt
streamlink --player-http twitch.tv/$name $quality --twitch-disable-ads --twitch-low-latency -o /home/$username/Videos/$name$current_date_time.mp4
else
filename= /home/$username/Documents/channellist.txt;
namesnum=0
while read -r line
do
	eval "name$namesnum=$line";
	echo "$line";
	namesnum=$((namesnum+1));
done < "$filename"
numchoices=$((namesnum-1));
echo "There are $namesnum channel names to choose, please select a number between [0-$numchoices]" 
read selectednum
eval "varname="name$selectednum;
eval "selectedchannel=\$$varname";
echo $selectednum was chosen this is channel $selectedchannel, is this okay?
read answer1
while [ "$answer1" != "y" ] || [ "$answer1" != "yes" ]
do
echo "select a number between [0-$numchoices]"
read selectednum
eval "varname="name$selectednum;
eval "selectedchannel=\$$varname";
echo "The current channel is "+$selectedchannel+" is this okay?"
read answer1
done < "$answer"
streamlink --player-http twitch.tv/$selectedchannel
echo "What quality do you want?"
read quality
streamlink --player-http twitch.tv/$selectedchannel $quality --twitch-disable-ads --twitch-low-latency -o /home/$username/Videos/$name$current_date_time.mp4
fi
