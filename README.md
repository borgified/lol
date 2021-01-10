## This script returns all the champions that have obtained a chest for the current season.

### prereqs:
- riot api key. get it [here](https://developer.riotgames.com/). save it into a file called
"apikey" in the same directory as `run.pl`.
- [jq](https://stedolan.github.io/jq/). on macs you can `brew install jq`

### usage:

./run.pl [ summonerName ]

### sample output
```
% ./run.sh utwig
Lux
Malzahar
```
