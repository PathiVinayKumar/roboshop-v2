curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
dnf install -y nodejs
cp cart.service /etc/systemd/system/cart.service


useradd -r -s /bin/false appuser
rm -rf /app
mkdir -p /app

curl -L -o /tmp/cart.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/cart.zip
cd /app
unzip /tmp/cart.zip
npm install --production
chown -R appuser:appuser /app
chmod o-rwx /app -R

systemctl daemon-reload
systemctl enable cart
systemctl restart cart