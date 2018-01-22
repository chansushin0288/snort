#snort 설치, 설정, 실행 테스트

#snort , daq 설치
cd /usr/local/src
cp /root/daq-2.0.6.tar.gz /usr/local/src
cp /root/snort-2.9.8.3.tar.gz /usr/local/src
tar -zxvf daq-2.0.6.tar.gz
tar -zxvf snort-2.9.8.3.tar.gz
cd /usr/local/src
cd daq-2.0.6
./configure
make
make install

cd ..
cd snort-2.9.8.3
./configure
make
make install

#snort –V 로 snort 실행테스트 및 daq 확인
snort -V

#snort conf 파일및 관련파일 복사및 백업파일생성
mkdir /etc/snort
cd /etc/snort
cp /root/snortrules-snapshot-2983.tar.gz ./
tar -zxvf snortrules-snapshot-2983.tar.gz
touch rules/white_list.rules rules/black_list.rules 
#==> 이거는 white list/blakc list 땜시
ls
cp -p /etc/snort/etc/* /etc/snort/
cp -p snort.conf snort.conf.original
#promisc 모드 설정
ifconfig eth0 promisc

#/etc/snort/snort.conf 설정
sed -i "45s/.*/ipvar HOME_NET 200.200.200.0\/24/g" /etc/snort/snort.conf
sed -i "48s/.*/ipvar EXTERNAL_NET \$HOME_NET/g" /etc/snort/snort.conf
sed -i "104s/.*/var RULE_PATH \/etc\/snort\/rules/g" /etc/snort/snort.conf
sed -i "105s/.*/var SO_RULE_PATH \/etc\/snort\/rules/g" /etc/snort/snort.conf
sed -i "106s/.*/var PREPROC_RULE_PATH \/etc\/snort\/rules/g" /etc/snort/snort.conf
sed -i "109s/.*/var WHITE_LIST_PATH \/etc\/snort\/rules/g" /etc/snort/snort.conf
sed -i "110s/.*/var BLACK_LIST_PATH \/etc\/snort\/rules/g" /etc/snort/snort.conf

#사용자,그룹생성 및 허가권 설정
groupadd -g 40000 snort
useradd snort -u 40000 -d /var/log/snort -s /sbin/nologin -c SNORT_IDS -g snort

#소유권 및 허가권 설정
cd /usr/local/src
chown -R snort:snort daq-2.0.6
chown -R snort:snort snort-2.9.8.3
chown -R snort:snort snort_dynamicsrc

chmod -R 700 daq-2.0.6
chmod -R 700 snort-2.9.8.3
chmod -R 700 snort_dynamicsrc

cd /var/log
chown -R snort:snort snort
chmod -R 700 snort

cd /etc
chown -R snort:snort snort
chmod -R 700 snort

cd /usr/local/lib
mkdir -p snort_dynamicrules
chown -R snort:snort snort*
chown -R snort:snort pkgconfig
chmod -R 700 snort*
chmod -R 700 pkgconfig

cd /usr/local/bin
chown -R snort:snort daq-modules-config
chown -R snort:snort u2*
chown -R snort:snort snort
chmod -R 700 daq-modules-config
chmod -R 700 u2*
chmod -R 700 snort*

#실행 테스트
snort -T -i eth0 -u snort -c /etc/snort/snort.conf

