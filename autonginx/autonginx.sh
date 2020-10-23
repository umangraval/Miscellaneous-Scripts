#!/bin/bash


usage() { echo "Usage: $0 -d domainName -p port" 1>&2; exit 1; }
printf 'Do you need SSL [y/n]: '
read -r ssl

while getopts ":d:p:" o; do
    case "${o}" in
        d)
            d=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${d}" ] || [ -z "${p}" ]; then
    usage
fi

cp sample ${d}
sed -i "s/domain_name/${d}/" ${d}
sed -i "s/port/${p}/" ${d}
mv ${d} /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/${d} /etc/nginx/sites-enabled/${d}

if ["$ssl" = "y"] ; then

echo 'Creating SSL Certificate'
certbot --nginx -d ${d}
fi

systemctl reload nginx
