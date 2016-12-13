FROM java:jre-alpine
MAINTAINER Yury Kozyrev "urakozz@gmail.com"

RUN apk --update add curl && \
    curl -o /tmp/dynamo.tar.gz -L http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz && \
    tar xvzf /tmp/dynamo.tar.gz && \
    rm -rf third_party_licenses LICENSE.txt && \
    apk --purge del curl

RUN mkdir /data

EXPOSE 8000
VOLUME ["/data"]

ENTRYPOINT ["java", "-Xmx512m", "-Djava.library.path=./DynamoDBLocal_lib", "-jar", "DynamoDBLocal.jar"]
CMD ["-sharedDb", "-dbPath", "/data"]
