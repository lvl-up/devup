#!/bin/bash
function find_plugin_page(){
  local slim_url=$(curl -s 'http://plugins.jetbrains.com/search/index?pr=idea&search=slim' | grep -E "<a.*?><span.*?>$1")

  if [[ "${slim_url}" =~ href=\"(.*)\" ]]
  then
     echo "http://plugins.jetbrains.com${BASH_REMATCH[1]}"
  else
    echo "plugin not found"
    exit 1
  fi


}
function find_match(){
    echo $(echo "$1" | perl -p -e "s/$2/\1/")
}

function find_plugin_download_url(){
  local result=$(curl -s $1 | tr -d '\n' | perl -p -e 's/&amp;/&/g' )
  local row=$(find_match "${result}" '.*(6.0.0.20131106.*?\/tr).*')
  local url=$(find_match "${row}" '.*?downld".*?href="(.*?)".*')
  echo "http://plugins.jetbrains.com${url}"
}
plugin_page_url=$(find_plugin_page "${1}")
echo "${plugin_page_url}"

plugin_download_url=$(find_plugin_download_url "${plugin_page_url}")
echo "$plugin_download_url"
wget --content-disposition "$plugin_download_url"