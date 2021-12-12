#!/bin/bash

while [ true ]
do
    mv -f /vagrant/folder1/* /vagrant/folder2/ 2>/dev/null
    sleep 10
done
