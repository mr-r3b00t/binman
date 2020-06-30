#!/bin/bash

#A binman that's greater than Oscar could ever be!
#created for post foothold enum by MrR3b00t (UK_Daniel_Card) and Crawl3r (@Monobehaviour)
#found this version - it's not the best one we made but I think we lost that one lulz!

set +x

banner="Binman - Find binaries without manuals for possible custom objects"
echo $banner
echo ""

if [ $(whoami) == 'root' ]; then
        echo "[!] You already root. $0 is designed to help find possible priv esc paths"
        echo "[!] Continuing... but the results maybe unreliable"
    echo ""
fi
# Added in / so that binman searches the whole file system (MrR3b00t)
#locations=(/bin /usr/bin /usr/sbin)
locations=(/bin /usr/bin /usr/sbin /)
all_bins=()
possible_bins=()

echo "[+] Searching for binaries in the following directories:"
for i in "${locations[@]}"; do
    # First we shall print everything to the screen. This can probably be removed (debug flagged)
    echo "$i"
    find_results=$( find $i \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null ) 
    results=($find_results)

    for cb in "${results[@]}"; do
        all_bins+=("$cb")
    done
done

echo "-> Found: ${#all_bins[@]} binaries"
echo ""
echo "[+] Checking all discovered binaries"

for j in "${all_bins[@]}"; do
    man_check=$(man --whatis "$j" 2>/dev/null)
    
    if [[ -z $man_check ]]; then
        possible_bins+=("$j")
    fi
done

echo ""
echo "[+] RESULTS"
echo "Possible bins: ${#possible_bins[@]}"
echo "Identified bins: ${possible_bins[@]}"
echo ""

if [ ${#possible_bins[@]} -lt 1 ]; then
    echo "No bins found... no point delving deeper. Exiting."
    exit 1
fi

echo "[+] Inspecting possibly binaries"
echo "//TODO: File, headers, runnable/usage, strings? etc"

# Now we want to loop through an array of possible bins that don't have manuals
# Do some deeper inspection on these files:
#  Print the rwx bits, ownership, file, headers, etc



echo ""
echo "--- done ---"
