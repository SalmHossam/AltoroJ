#!/bin/bash

docker build -t altoroj .

docker run -d -p 8079:8080 --name altoroj-container altoroj
