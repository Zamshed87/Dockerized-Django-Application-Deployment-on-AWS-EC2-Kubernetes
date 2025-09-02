# Dockerized Django Application Deployment on AWS EC2

## To Run This Application

### 1. Create A Virtual Env
- python -m venv myvenv
- virtualenv myenv (for Linux)

### 2. Activate The Virtual Env
- source myenv/bin/activate (for Linux)
- myvenv/Scripts/activate (for Windows)

### 3. Install Packages
- pip install -r requirements.txt

### 4. Run This Application
- python manage.py runserver 0.0.0.0:8000

### 5. OS Level Dependencies (Linux)
```bash
apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    zlib1g-dev \
    libffi-dev \
    libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
```

### 6. Apply Migrations
Run the following inside your EC2 container:
```bash
docker compose exec web bash
```
Then inside the container:
```bash
python manage.py makemigrations
python manage.py migrate
```
This will create all tables in your PostgreSQL database according to your models.

### 7. (Optional) Create a Superuser
If you want to access the admin panel:
```bash
python manage.py createsuperuser
```

### 8. Collect Static Files (if needed)
```bash
python manage.py collectstatic --noinput
```

### 9. Restart the Container (if needed)
```bash
docker compose restart web
```

