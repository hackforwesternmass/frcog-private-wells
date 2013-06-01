import psycopg2, os

DBError = psycopg2.Error

class DatabaseManager:
    """ Manages SQL operations on the Weasel database """
    
    def __init__(self, db_host, db_catalog, db_port, db_user, db_password):
        """ Initializes a bot manager with the given configuration.
            
            Keyword arguments:
            db_host -- The database host to connect to 
            db_catalog -- The catalog to connect to
            db_user -- The database user to connect as
        """
        self.db_conn = psycopg2.connect(host=db_host, database=db_catalog, 
                                        user=db_user, port=db_port, password=db_password)

    def shutdown(self):
        """ Closes the database connection and decommits any active transactions"""
        self.db_conn.rollback()
        self.db_conn.close()

    def get_wells_view(self):
        results = self.exec_query("""
            select dep_well_id, street_address1, 
                 street_address2, city, latitude, longitude
                 municipalies_id, R.name as well_type,
                 M.name as municipality_name

                 from wells W inner join well_types R
                 on W.well_types_id= R.id

                 inner join municipalities M
                 on M.id = W.municipalities_id""")
        return results;


    def exec_query(self, command, *args):
        """ Executes an SQL query with the specified set of parameter values
            Returns a list of records matching the query
            
            Keyword arguments:
            command -- The command to execute
            *args -- Non-keyword arguments, specify positional parameter values to command
        """
        c = self.db_conn.cursor()
        try:
           c.execute(command, args) 
           results = c.fetchall()
        except DBError, e:
           raise e 
        finally:
            c.close()
        return results
    
    def exec_cmd(self, command, *args, **kwargs):
        """ Executes an SQL command with the specified set of parameter values
            
            Keyword arguments:
            command -- The command to execute
            *args -- Non-keyword arguments, specify positional parameter values to command
            commit -- Optional, defaults to True. Indicates that a 
                      commit should be performed after executing the statement
            lastrow -- Optional, defaults to False. Indicates if the execute statement 
                        should be treated as an insert statement and the id of the last 
                        inserted row should be returned.
        """
        lastrow = None
        c = self.db_conn.cursor()
        try:
           c.execute(command, args) 
           if 'lastrow' in kwargs and kwargs['lastrow']:
               lastrow = c.fetchone()[0]
           if 'commit' in kwargs:
               if kwargs['commit']:
                   self.db_conn.commit()
           else:
               self.db_conn.commit()
        except DBError, e:
           raise e 
        finally:
            c.close()
        return lastrow
    
