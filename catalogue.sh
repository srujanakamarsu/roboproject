echo -e  "\e36m>>>>>> create catalogue service file <<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service
echo -e  "\e36m>>>>>> create mongodb repo file <<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e  "\e36m>>>>>> install node js repos <<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e  "\e36m>>>>>> install node js <<<<<<\e[0m"
yum install nodejs -y
echo -e  "\e36m>>>>>> create application user <<<<<<\e[0m"
useradd roboshop
echo -e  "\e36m>>>>>> create application directory <<<<<<\e[0m"
mkdir /app 
echo -e  "\e36m>>>>>> download application content <<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
echo -e  "\e36m>>>>>> extract application content <<<<<<\e[0m"
cd /app 
unzip /tmp/catalogue.zip
cd /app 
echo -e  "\e36m>>>>>> download nodejs dependencies <<<<<<\e[0m"
npm install 
echo -e  "\e36m>>>>>> install mongo client <<<<<<\e[0m"
yum install mongodb-org-shell -y
echo -e  "\e36m>>>>>> load catalogue schema <<<<<<\e[0m"
mongo --host mongodb.vyshu.online </app/schema/catalogue.js
echo -e  "\e36m>>>>>> start catalogue service <<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue 
systemctl restart catalogue
