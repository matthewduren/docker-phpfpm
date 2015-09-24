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

# start php-fpm
echo "Starting php5-fpm"
exec /usr/sbin/php5-fpm
