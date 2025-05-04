#!/bin/bash
echo "┌────────────────────────┐"
echo "│      BashArmor™        │"
echo "└────────────────────────┘"
sleep 1 && clear

# Use arguments if passed
file="$1"
repeat="$2"

# Prompt for file if not given
if [ -z "$file" ]; then
    echo -e "\nFiles in directory:\n"
    tree
    ls
    sleep 1.5 && clear
    file=$(find . -maxdepth 1 -type f | sed 's|^\./||' | fzf --prompt="Select a file: ")
    [ -z "$file" ] && echo "No file selected. Exiting." && exit 1
fi

# Prompt for repeat count if not given
if [ -z "$repeat" ]; then
    read -p "Enter number of repeats: " repeat
fi

php exec.php "$file" "$repeat"

echo "Complete, exiting in 3s" && sleep 3 && echo ""
clear && echo " Thanks For Choosing Szmelc "
exit
