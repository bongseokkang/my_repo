#!/bin/bash
GREEN='\033[1;32m'
NO_COLOR='\033[0m'

##########  추가 설치 ################
apt -y install tmux
#apt -y install mc
#apt -y cockpit

##########  .vimrc 생성  ##############
cd /home/vuno
sudo -u vuno cat <<EOF > .vimrc
set number    " line 표시
set ai    " auto indent
set si " smart indent
set cindent    " c style indent
set shiftwidth=4    " 자동 공백 채움 시 4칸
set tabstop=4    " tab을 4칸 공백으로
set ignorecase    " 검색 시 대소문자 무시
set hlsearch    " 검색 시 하이라이트
set nocompatible    " 방향키로 이동 가능
set fileencodings=utf-8,euc-kr    " 파일 저장 인코딩 : utf-8, euc-kr
set fencs=ucs-bom,utf-8,euc-kr    " 한글 파일은 euc-kr, 유니코드는 유니코드
set bs=indent,eol,start    " backspace 사용가능
set ruler    " 상태 표시줄에 커서 위치 표시
set title    " 제목 표시
set showmatch    " 다른 코딩 프로그램처럼 매칭되는 괄호 보여줌
set wmnu    " tab 을 눌렀을 때 자동완성 가능한 목록
syntax on    " 문법 하이라이트 on
filetype indent on    " 파일 종류에 따른 구문 강조
set mouse=a    " 커서 이동을 마우스로 가능하도록
EOF
##########  .nanorc 생성  ##############
cd /home/vuno
sudo -u vuno cat <<EOF > .nanorc
set mouse    " mouse 사용
EOF
##########  .tmux.conf 생성  ##############
cd /home/vuno
sudo -u vuno cat <<EOF > .tmux.conf
set -g mouse on
set -g history-limit 100000
EOF

########## pgAdmin 추가 #############
#docker run -p 6081:80 --restart always -e 'PGADMIN_DEFAULT_EMAIL=admin@vuno.co' -e #'PGADMIN_DEFAULT_PASSWORD=Vuno2020!' -d --name=gravuty_pgadmin --net=gravuty dpage/pgadmin4