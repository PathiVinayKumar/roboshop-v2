dnf install -y java-21-openjdk java-21-openjdk-devel maven
cp orders.service /etc/systemd/system/orders.service


useradd -r -s /bin/false appuser
rm -rf /app
mkdir -p /app

curl -L -o /tmp/orders.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/orders.zip
cd /app
unzip /tmp/orders.zip
mvn clean package -DskipTests
cp target/orders.jar /app/orders.jar
chown -R appuser:appuser /app
chmod o-rwx /app -R

systemctl daemon-reload
systemctl enable orders
systemctl restart orders