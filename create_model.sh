# Regenerates the SqlAlchemy models if the Postgres database changes
# You must set the password for the Heroku account to use this script
# Depends on sqlautocode (pip install sqlautocode)
sqlautocode "postgres://crwpuwcgrodlii:${FRCOG_PASSWORD}@ec2-23-21-130-168.compute-1.amazonaws.com/dcrmabu3rp1e14" --output models.py
