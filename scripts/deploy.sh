cd /code/pineapple
git reset --hard HEAD
git pull -f
if [ -d "venv" ]; then 
echo "**> virtualenv exists" 
else 
echo "**> creating virtualenv" 
virtualenv venv 
fi
. venv/bin/activate
pip install -r requirements.txt
python manage.py makemigrations
python manage.py migrate
python manage.py test
python manage.py collectstatic
python manage.py load_fixtures
BUILD_ID=dontKillMe nohup gunicorn pineapple.wsgi:application -c conf/gunicorn_conf.py&