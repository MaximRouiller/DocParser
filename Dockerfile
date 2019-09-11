FROM alpine/git:latest
VOLUME /data
ARG product=dotnet

ENV DATE=2019-01-01
ENV REPOSITORY=https://github.com/dotnet/docs
ENV PRODUCT=${product}
ENV SIGNIFICANT_CHANGE=25
ENV ROOT_FOLDER=docs

ENV BASE_URL=https://docs.microsoft.com/${PRODUCT}/

RUN apk add --no-cache bash
COPY run.sh ./run.sh
RUN chmod +x ./run.sh

ENTRYPOINT ./run.sh ${DATE} ${REPOSITORY} ${BASE_URL} ${PRODUCT} ${SIGNIFICANT_CHANGE} ${ROOT_FOLDER}