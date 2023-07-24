echo ">>>>>> create catalogue service file <<<<<<"
cp catalogue.service /etc/systemd/system/catalogue.service
echo ">>>>>> create mongodb repo file <<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo ">>>>>> install node js repos <<<<<<"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo ">>>>>> install node js <<<<<<"
yum install nodejs -y
echo ">>>>>> create application user <<<<<<"
useradd roboshop
echo ">>>>>> create application directory <<<<<<"
mkdir /app 
echo ">>>>>> download application content <<<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
echo ">>>>>> extract application content <<<<<<"
cd /app 
unzip /tmp/catalogue.zip
cd /app 
echo ">>>>>> download nodejs dependencies <<<<<<"
npm install 
echo ">>>>>> install mongo client <<<<<<"
yum install mongodb-org-shell -y
echo ">>>>>> load catalogue schema <<<<<<"
mongo --host mongodb.vyshu.online </app/schema/catalogue.js
echo ">>>>>> start catalogue service <<<<<<"
systemctl daemon-reload
systemctl enable catalogue 
systemctl restart catalogue
