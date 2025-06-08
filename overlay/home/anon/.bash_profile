# overlay/home/anon/.bash_profile
# Auto-unlock encrypted storage on login
if [ -b /dev/sda3 ] && [ ! -b /dev/mapper/persistent-crypt ]; then
    echo ""
    echo "🔒 Encrypted storage detected."
    read -p "Unlock storage? (y/n): " unlock
    if [ "$unlock" = "y" ] || [ "$unlock" = "Y" ]; then
        unlock-storage
	dbus-run-session labwc
    else
        echo "Storage remains locked. Run 'unlock-storage' later to access files."
    fi
elif [ -b /dev/mapper/persistent-crypt ]; then
    echo "🔓 Encrypted storage already unlocked."
    # Make sure sync mount is ready
    unlock-storage >/dev/null 2>&1
fi
