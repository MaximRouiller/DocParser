FROM python:3-alpine3.10
VOLUME /data
ARG product=dotnet

ENV REPOSITORY=https://github.com/dotnet/docs
ENV PRODUCT=${product}
ENV DATE=2019-01-01
ENV SIGNIFICANT_CHANGE=25
ENV ROOT_FOLDER=docs

ENV BASE_URL=https://docs.microsoft.com/${PRODUCT}/

RUN apk add --no-cache bash; \
    apk add --no-cache git
COPY run.sh ./run.sh
COPY process.py ./process.py
RUN chmod +x ./run.sh

ENTRYPOINT ./run.sh ${DATE} ${REPOSITORY} ${BASE_URL} ${PRODUCT} ${SIGNIFICANT_CHANGE} ${ROOT_FOLDER}