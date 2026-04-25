curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
dnf install -y nodejs
cp user.service /etc/systemd/system/user.service


useradd -r -s /bin/false appuser
rm -rf /app
mkdir -p /app

curl -L -o /tmp/user.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/user.zip
cd /app
unzip /tmp/user.zip
npm install --production
chown -R appuser:appuser /app
chmod o-rwx /app -R

systemctl daemon-reload
systemctl enable user
systemctl restart user