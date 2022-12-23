# World Series of Spades Statistics
## wsos_spades_stats
App to track statistics for World Series of Spades data, 2022-2023

* Ruby version 2.7.4
* Current through Week 8, December 22, 2022

### Stats only
* Run: `ruby ./lib/runner.rb XY`
* `XY` represents two-digit week number; e.g. `08`
* Output: `outputDiv08CSV.csv`

### Search function
* Run: `ruby ./lib/search.rb XY`
* `XY` represents two-digit week number; e.g. `08`
* Output: `outputDiv08CSV.csv`
* Enter partial team name
    * Returns Full team name, record, conference, division
* Choose to search by:
    * (C)onference: games played within conference
    * (D)ivision: games played within division
    * (H)ome: games played with home rules
    * (A)way: games played with opponent's home rules
    * (W)ins: games won
    * (L)osses: games lost
    * (T)eam: search games against specific team
    * (X): return all games played, no filter 