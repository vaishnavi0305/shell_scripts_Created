#!/bin/bash

#File containing the list of users

USER_FILE="userlist.txt"

TARGET_GROUP="devops"

if [[ ! -f "$USER_FILE" ]]; then
	echo "'$USER_FILE' not found!"
	exit 1
fi

#loop through each line in a file

while read -r user; do
	if id "$user" &>/dev/null; then
		usermod -aG "$TARGET_GROUP" "$user"
		echo "Added $user to $TARGET_GROUP group."
	else
		echo "User $user does not exist, creating one!"
		useradd $user
		usermod -aG "$TARGET_GROUP" "$user"
                echo "Added $user to $TARGET_GROUP group."
	fi
done < "$USER_FILE"
