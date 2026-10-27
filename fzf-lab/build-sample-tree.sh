#!/usr/bin/env bash
# Build the sample tree the fzf lab runs against.
# Safe to re-run: it recreates sample-tree/ from scratch.
# Every file is invented for this guide — sample documents,
# song names and photo names from nobody's real life.
set -eu
cd "$(dirname "$0")"
rm -rf sample-tree
mkdir -p sample-tree/documents sample-tree/music sample-tree/photos

doc() { printf '%s\n' "$2" > "sample-tree/documents/$1"; }

doc annual-report-2023.txt "Annual report 2023
The community garden grew 40 beds this year.
The spring fair raised enough for a new shed."
doc annual-report-2024.txt "Annual report 2024
The community garden grew 46 beds this year.
The autumn fair raised enough for a water tank."
doc budget-2024.txt "Budget 2024
Seeds and compost: 120
Tools and repairs: 85
Hall hire for meetings: 60"
doc budget-2025.txt "Budget 2025
Seeds and compost: 130
Tools and repairs: 90
Hall hire for meetings: 60"
doc meeting-notes-march.txt "Meeting notes, March
The bench by the gate needs new bolts.
Priya will ask the council about the tap."
doc meeting-notes-april.txt "Meeting notes, April
Planting day is the second Saturday.
Bring spare gloves for new members."
doc letter-to-the-library.txt "Dear library team,
Thank you for the seed library box.
The children loved the sunflower packets."
doc recipe-pancakes.txt "Pancakes
200 g flour, 2 eggs, 300 ml milk.
A pinch of cinnamon in the batter.
Fry small ladles, two minutes a side."
doc recipe-tomato-soup.txt "Tomato soup
Two tins of tomatoes, one onion, garlic.
Simmer twenty minutes, blend, add basil."
doc shopping-list.txt "Shopping list
Flour, eggs, milk, butter.
Cinnamon, sugar, lemons.
A new notebook for the hall."
doc holiday-plan.txt "Holiday plan
Day 1: arrive, walk to the harbour.
Day 2: market in the morning; mulled apple
juice with cinnamon sticks in the evening.
Day 3: the lighthouse walk."
doc invoice-1042.txt "Invoice 1042
Hall hire, one evening: 45
Payable within 30 days."
doc invoice-1043.txt "Invoice 1043
Printing, 200 leaflets: 38
Payable within 30 days."
doc readme.txt "This folder holds the garden club papers.
Reports by year, budgets, recipes, letters.
Nothing here is real; it is a practice tree."

for song in midnight-train rain-on-the-roof song-for-a-winter-morning \
            the-blue-door dancing-in-the-kitchen highway-lights \
            quiet-river summer-postcard; do
  printf 'a song file, in name only\n' > "sample-tree/music/$song.mp3"
done

for photo in birthday-cake garden-in-may the-old-bridge \
             sunset-over-the-bay cat-on-the-porch; do
  printf 'a photo file, in name only\n' > "sample-tree/photos/$photo.jpg"
done

find sample-tree -type f | sort
echo "files: $(find sample-tree -type f | wc -l)"
