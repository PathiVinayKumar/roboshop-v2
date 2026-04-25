cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo

dnf install -y rabbitmq-server erlang
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

rabbitmq-plugins enable rabbitmq_management
systemctl restart rabbitmq-server

rabbitmqctl add_user roboshop RoboShop@1
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"