# this tee is to append the heading also into log file.
source common.sh
component_name=frontend

echo -e "${hs} Install Nginx ${he}" | tee -a ${log_file} 
dnf install -y nginx &>>${log_file}
echo $?

echo -e "${hs} Copy Nginx ${he}" | tee -a ${log_file}
cp nginx.conf /etc/nginx/nginx.conf &>>/tmp/nginx-output-conf /tmp/roboshop.log
echo $?


echo -e "${hs} Install Node js ${he}" | tee -a ${log_file}
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash - &>>/tmp/roboshop.log
dnf install -y nodejs  &>>${log_file}
echo $?

echo -e "${hs} extracting the code and installing Nginx ${he}"
curl -L -o /tmp/frontend.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/frontend.zip &>/tmp/null
rm -rf /tmp/frontend  &>>${log_file}
mkdir -p /tmp/frontend &>>${log_file}
cd /tmp/frontend &>>${log_file}
echo $?

echo -e "${hs} Installing frontend ${he}" | tee -a /tmp/roboshop.log
unzip /tmp/frontend.zip &>>${log_file}
npm install &>>${log_file}
echo $?


npm run build  &>>${log_file}
rm -rf /usr/share/nginx/html/* &>>${log_file}
cp -r out/* /usr/share/nginx/html/ &>>${log_file}
echo $?

echo -e "${hs} Restarting the Nginx ${he}" | tee -a ${log_file}
systemctl restart nginx
systemctl enable nginx
echo $?

