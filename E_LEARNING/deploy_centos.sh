# deploy environment production
#------------------------------
# This script is for setting up a production environment on a CentOS 8 server.
sudo dnf groupinstall "Development Tools" -y
sudo dnf install gcc openssl-devel bzip2-devel libffi-devel wget make zlib-devel xz-devel -y

# Install Python 3.11
cd /usr/src
sudo wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz
sudo tar xzf Python-3.11.9.tgz
cd Python-3.11.9
sudo ./configure --enable-optimizations
sudo make altinstall


# Create env for Python 3.11
cd /var/www/SMART_DIGITAL_SCHOOL/E_LEARNING/E_LEARNING
python3.11 -m venv env
source env/bin/activate

# Install pip and requirements
pip install --upgrade pip
pip install -r requirements.txt

# Install Gunicorn for serving the application
pip install gunicorn

# Create a systemd service file for Gunicorn
gunicorn -w 4 -b 0.0.0.0:8000 wsgi:app




