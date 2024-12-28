

docker build -t python_workbench .

docker run -it --rm -p 8888:8888 -v /home/sanjeet/Desktop/x_engineering_bootcamp_2025/python_workbenc/app:/home/pyuser/app python_workbench jupyter
docker run -it --rm python_workbench

docker run -it --rm -p 8888:8888 -v ${hostfolder}/app:${dockerfolder} python_workbench jupyter
docker run -it --rm python_workbench




hostfolder="$(pwd)"
dockerfolder="/home/sparkuser/app"

docker run --rm -d --name spark-container \
-p 4040:4040 -p 4041:4041 -p 18080:18080 \
-v ${hostfolder}/app:${dockerfolder} -v ${hostfolder}/event_logs:/home/spark/event_logs \
spark-dp-101:latest jupyter



Can you create a dockerfile for a python development environment for data engineering. This environment should expose python through jupyter notebook.
run command should be like
hostfolder="$(pwd)"
dockerfolder="/home/pyuser/app"
docker run -p 8888:8888 -v ${hostfolder}/app:${dockerfolder} python-data-eng-env
The main packages in this environment (through requirements.txt):

1. Python 3.12
2. Polars, numpy, scipy, sklearn, arrow
3. should be able to read parquet file and print in dataframe (add any necessary package to requirements.txt or jars to dockerfile)
4. Debian packages like vim to edit any file
5. An entrypoint.sh file that should route to either jupyter or to python shell in terminal
6. A user named pyuser
7. /home/pyuser/app as working directory

Generate instruction to build and run the container

