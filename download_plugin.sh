#!/bin/bash
jetbrains_base_url='http://plugins.jetbrains.com'

function find_match(){
    echo $(echo "$1" | perl -p -e "s/$2/\1/")
}

function find_plugin_page(){
  local search_results=$(curl -s "${jetbrains_base_url}/search/index?pr=idea&search=$1" | tr -d '\n')

  local plugin_uri=$(find_match "${search_results}" ".*?dl class=\"category\".*?href=\"(.*?)\"><span.*?>$1<\/span.*" )

  echo "${jetbrains_base_url}${plugin_uri}"
}


function find_plugin_download_url(){
  local plugin_page_url=$1
  local version=$2

  local plugin_page=$(curl -s ${plugin_page_url} | tr -d '\n' | perl -p -e 's/&amp;/&/g' )
  local row_with_version_in_it=$(find_match "${plugin_page}" ".*(${version}.*?\/tr).*")
  local download_uri=$(find_match "${row_with_version_in_it}" '.*?downld".*?href="(.*?)".*')
  echo "${jetbrains_base_url}${download_uri}"
}

plugin_page_url=$(find_plugin_page "${1}")
plugin_download_url=$(find_plugin_download_url "${plugin_page_url}" $2)
echo "$plugin_download_url"
wget --content-disposition "$plugin_download_url"