FROM openjdk:8u191-jre-alpine3.9

#RUN apk add Curl jq

#Install jq
#RUN apt-get update
#RUN apt-get -y install sudo
#RUN apt-get -y install jq

#WORKSPACE
WORKDIR /usr/share/framework

# ADD .jar under target from host
# into this image
ADD target/practice1.jar 				practice1.jar
ADD target/practice1-tests.jar 			practice1-tests.jar
ADD target/libs							libs

# In case of any other dependency like .csv / .json / .xls


# ADD suite files
ADD src/test/resources/runner/Employee.xml 				Employee.xml
ADD src/test/resources/runner/Backtolist.xml 			Backtolist.xml
ADD src/test/resources/runner/QEdge.xml      			QEdge.xml

#ADD health check script
#ADD src/test/resources/docker/healthcheck.sh					Healthcheck.sh
#RUN wget https://s3.amazonaws.com/selenium-docker/healthcheck/healthcheck.sh

# ENTRYPOINT: BROWSER, HUB_HOST, MODULE
ENTRYPOINT java -cp practice1.jar:practice1-tests.jar:libs/* -Dcucumber.options="classpath:features" org.testng.TestNG $MODULE
#ENTRYPOINT sh healthcheck.sh