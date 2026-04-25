source common.sh
component_name=catalogue
echo Log file Output: ${log_file}


echo -e "${hs} Install GoLang & MySQL ${he}" | tee -a ${log_file} 
dnf install -y golang git mysql8.4 &>>{log_file}
echo $?

echo -e "${hs} Copying the ${component_name} file ${he}" | tee -a ${log_file} 
cp catalogue.service /etc/systemd/system/catalogue.service &>>{log_file}
echo $? 

echo -e "${hs} Downloading the file ${he}" | tee -a ${log_file} 
curl -L -o /tmp/${component_name}.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/catalogue.zip
echo $?

echo -e "${hs} Create folder for application ${he}" | tee -a ${log_file} 
rm -rf /app &>>{log_file}
mkdir -p /app &>>{log_file}
cd /app &>>{log_file}
echo $?


echo -e "${hs} Extract Application ${he}" | tee -a ${log_file}  &>>{log_file}
unzip /tmp/${component_name}.zip &>>{log_file}
echo $?


echo -e "${hs} Scehama Update ${he}" | tee -a ${log_file}  &>>{log_file}
mysql -h mysql-dev.vinaykumar.online -u root -pRoboShop@1 < db/schema.sql &>>{log_file}
mysql -h mysql-dev.vinaykumar.online -u root -pRoboShop@1 < db/app-user.sql &>>{log_file}
mysql -h mysql-dev.vinaykumar.online -u root -pRoboShop@1 catalogue < db/master-data.sql &>>{log_file}
echo $?


echo -e "${hs} Creating the application user ${he}" | tee -a ${log_file} 
useradd -r -s /bin/false appuser &>>{log_file}
cd /app &>>{log_file}
echo $?

echo -e "${hs} Compile Application Code ${he}" | tee -a ${log_file} 
go mod tidy &>>{log_file}
CGO_ENABLED=0 go build -o /app/${component_name} .  &>>{log_file}
echo $?

echo -e "${hs} Appying the permission for application folder ${he}" | tee -a ${log_file} 
chown -R appuser:appuser /app  &>>{log_file}
chmod -R o-rwx /app  &>>{log_file}
echo $? 


echo -e "${hs} Reloading and Restarting ${he}" | tee -a ${log_file} 
systemctl daemon-reload  &>>{log_file}
systemctl enable ${component_name}
systemctl restart ${component_name}
echo $?
