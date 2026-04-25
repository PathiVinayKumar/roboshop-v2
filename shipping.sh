dnf install -y java-21-openjdk java-21-openjdk-devel maven mysql8.4
cp shipping.service /etc/systemd/system/shipping.service


curl -L -o /tmp/shipping.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/shipping.zip
rm -rf /app
mkdir -p /app
cd /app
unzip /tmp/shipping.zip
mysql -h mysql-dev.vinaykumar.online -u root -pRoboShop@1 < db/schema.sql
mysql -h mysql-dev.vinaykumar.online -u root -pRoboShop@1 < db/app-user.sql

useradd -r -s /bin/false appuser
cd /app
mvn clean package -DskipTests
cp target/shipping.jar /app/shipping.jar
chown -R appuser:appuser /app
chmod o-rwx /app -R

systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping