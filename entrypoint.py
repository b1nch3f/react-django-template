import os
import sys
import subprocess


# Django migrations
os.system("python3 manage.py makemigrations")
os.system("python3 manage.py migrate")

os.system("python3 manage.py runserver 0.0.0.0:8080")