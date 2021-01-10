#!/usr/bin/env bash
set -eu

TOKEN=$(cat apikey)

h1="User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:84.0) Gecko/20100101 Firefox/84.0"
h2="Accept-Language: en-US,en;q=0.5"
h3="Accept-Charset: application/x-www-form-urlencoded; charset=UTF-8"
h4="Origin: https://developer.riotgames.com"
h5="X-Riot-Token: $TOKEN"

# input: summonerName
# output: summonerId
# usage: summonerId=$(getSummonerId utwig)
function getSummonerId {
  url="https://na1.api.riotgames.com/lol/summoner/v4/summoners/by-name/$1"
  curl -s -H "$h1" -H "$h2" -H "$h3" -H "$h4" -H "$h5" $url | jq -r .id
}

# input: summonerId
# output: json blob of owned champions 
# usage: getChampionMastery $summonerId | jq '.[]|select(.chestGranted==true)'
function getChampionMastery {
  url="https://na1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/$1"
  curl -s -H "$h1" -H "$h2" -H "$h3" -H "$h4" -H "$h5" $url
}

# input: championId
# output: championName
# usage: getChampionName 143
function getChampionName {
  if [ ! -f champions ]; then
    curl -s http://ddragon.leagueoflegends.com/cdn/11.1.1/data/en_US/champion.json > champions
    cat champions| jq -r --arg x $1 '.data[]|select(.key==$x)|.id'
  else
    cat champions| jq -r --arg x $1 '.data[]|select(.key==$x)|.id'
  fi
}


# main
function main {
  debug=0
  # summonerName=utwig
  summonerName=$1
  summonerId=$(getSummonerId $summonerName)
  [ $debug = 1 ] && echo "summonerId: $summonerId"
  for champId in `getChampionMastery $summonerId | jq '.[]|select(.chestGranted==true)|.championId'`; do
  [ $debug = 1 ] && echo "champId: $champId"
    getChampionName $champId
  done
}

if [[ $# != 1 ]]; then
  echo "usage: $0 mycon"
  exit 1
fi
main $1
