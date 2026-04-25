dnf install -y python3 python3-pip
cp payment.service /etc/systemd/system/payment.service


useradd -r -s /bin/false appuser
rm -rf /app
mkdir -p /app

curl -L -o /tmp/payment.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/payment.zip
cd /app
unzip /tmp/payment.zip
pip3 install -r requirements.txt
chown -R appuser:appuser /app
chmod o-rwx /app -R

systemctl daemon-reload
systemctl enable payment
systemctl restart payment