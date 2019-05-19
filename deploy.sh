#!/bin/bash
set -e

echo $GITHUB_AUTH_SECRET > ~/.git-credentials && chmod 0600 ~/.git-credentials
git config --global credential.helper store
git config --global user.email "dcr317duan@163.com"
git config --global user.name "dcr-bot"
git config --global push.default simple

rm -rf deployment
git clone -b master https://github.com/dcr309duan/dcr309duan.github.io.git deployment
rsync -av --delete --exclude ".git" public/ deployment
cd deployment
echo "[![Build Status](https://travis-ci.com/dcr309duan/academic-kickstart.svg?branch=master)](https://travis-ci.com/dcr309duan/academic-kickstart)" >> README.md
git add -A
git pull
git commit -m "rebuilding site on `date`, commit ${TRAVIS_COMMIT} and job ${TRAVIS_JOB_NUMBER}" || true
git push

cd ..
rm -rf deployment
