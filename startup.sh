#!/bin/sh

# Function to update the fpm configuration to make the service environment variables available
setEnvironmentVariable() {
    if [ -z "$2" ]; then
            echo "Environment variable '$1' not set."
            return
    fi

    # Check whether variable already exists
    if grep -q $1 /etc/php5/fpm/pool.d/www.conf; then
        # Reset variable
        echo "Resetting variable $1"
        sed -i "s/^env\[$1.*/env[$1] = '$2'/g" /etc/php5/fpm/pool.d/www.conf
    else
        # Add variable
        echo "Adding variable ${1}"
        echo "env[$1] = '$2'" >> /etc/php5/fpm/pool.d/www.conf
    fi
}

# Grep for variables that look like MySQL (MYSQL)
for _curVar in `env | grep APP_ | awk -F = '{print $1}'`;do
    # awk has split them by the equals sign
    # Pass the name and value to our function

    key=${_curVar}
    val=${!_curVar}

    # echo "Setting variable $key: $val"
    setEnvironmentVariable $key $val
done

<<<<<<< HEAD
# Check for xdebug
if [[ "$APP_XDEBUG" == "true" ]]; then
    sed -i "s/\$VIRTUAL_HOST/$VIRTUAL_HOST/g" /etc/php5/mods-available/xdebug.ini.tmpl
    echo -e "\n$XDEBUG_CONFIG" | sed -r "s/ /\n/g" | sed -r "s/remote_/xdebug.remote_/g" >> /etc/php5/mods-available/xdebug.ini.tmpl
    mv /etc/php5/mods-available/xdebug.ini.tmpl /etc/php5/mods-available/xdebug.ini
fi

# start php-fpm
echo "Starting php5-fpm"
php5enmod mcrypt > /dev/null 2>&1
=======
# start php-fpm
echo "Starting php5-fpm"
>>>>>>> 74a24699c58e1cf5d1c1c7d15bdc9026f7d8c43f
exec /usr/sbin/php5-fpm
